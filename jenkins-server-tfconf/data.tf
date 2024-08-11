# Data source to get the Avaiblibility zones
data "aws_availability_zones" "available" {
  state = "available"
}

# Data sorce to get the jenkins server AMI that is ubuntu us-east-1

data "aws_ami" "jenkins_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
