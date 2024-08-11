#Creating VPC for Jenkins-Server

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "jenkins-vpc"
  cidr = var.vpc_cidr

  azs             = data.aws_availability_zones.available.names
  private_subnets = var.private_subnets_cidr
  public_subnets  = var.public_subnets_cidr

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Terraform   = "true"
    Environment = "dev-jenkins"
  }
}

#Creating Security Group for Jenkins Server

module "jenkins_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "jenkins-sg"
  description = "Security group for Jenkins EC2"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      description = "8080 port for jenkins"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "SSH"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "Outbound rules for jenkins server"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  tags = {
    Name        = "SG for jenkins server"
    Environment = "dev-jenkins"
  }
}

#Creating EC2 for Jenkins Server

module "jenkins_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "jenkins-instance"

  instance_type               = var.instance_type_jenkins
  ami                         = data.aws_ami.jenkins_ami.id
  key_name                    = var.jenkins_ssh-keyname
  vpc_security_group_ids      = [module.jenkins_sg.security_group_id]
  subnet_id                   = module.vpc.public_subnets[0]
  associate_public_ip_address = "true"

  tags = {
    Name        = "Jenkins-server"
    Terraform   = "true"
    Environment = "dev-jenkins"
  }
  user_data = file("${path.module}/jenkins-userdata.sh")
}