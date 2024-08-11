module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "EKS-VPC"
  cidr = var.vpc_cidr

  azs             = data.aws_availability_zones.available.names
  private_subnets = var.private_subnets_cidr
  public_subnets  = var.public_subnets_cidr

  enable_nat_gateway   = true
  enable_dns_hostnames = true
  single_nat_gateway   = true

  tags = {
    Terraform                          = "true"
    Environment                        = "Dev-EKS"
    "kubernetes.io/cluster/my-cluster" = "shared" ## these tags are required 
    ### Get it from Aws Eks documentation
  }
  private_subnet_tags = {
    "kubernetes.io/cluster/my-cluster" = "shared"
    "kubernetes.io/role/internal-elb"  = 1
  }
  public_subnet_tags = {
    "kubernetes.io/cluster/my-cluster" = "shared"
    "kubernetes.io/role/elb"           = 1
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "my-cluster"
  cluster_version = "1.30"
  create_cloudwatch_log_group = false

  cluster_endpoint_public_access = true

  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = var.private_subnets_cidr
  control_plane_subnet_ids = var.private_subnets_cidr


  eks_managed_node_groups = {
    nodes = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t3.medium"]

      min_size     = 1
      max_size     = 1
      desired_size = 1
    }
  }

  # Cluster access entry
  # To add the current caller identity as an administrator
  enable_cluster_creator_admin_permissions = true

 # access_entries = {
 #   # One access entry with a policy associated
 #   dev-team = {
 #     kubernetes_groups = []
 #     principal_arn     = "arn:aws:iam::654654270687:user/kk_labs_user_712883"
 #
 #     policy_associations = {
 #       nodes = {
 #         policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSViewPolicy"
 #         access_scope = {
 #           namespaces = ["default"]
 #           type       = "namespace"
 #         }
 #       }
 #     }
 #   }
 # }

  tags = {
    Environment = "dev-EKS"
    Terraform   = "true"
  }
}

