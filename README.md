# terraform-jenkins-eks
YT Gauri end to end DevOps Project: Deploying an EKS Cluster with terraform and Jenkins
Step 1 - First copy s3.tf and dynamo.tf files and run "terrform apply" so that s3 bucket and dynamodb table will craete before deplying the other resources.

Step 2 - Copy all the files of jenkins-server-tfconf and run "terraform apply"

Step 3 - eks-tfconf directory has all EKS erraform conf files to create the EKS cluster