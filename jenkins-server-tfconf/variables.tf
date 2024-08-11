variable "vpc_cidr" {
  type        = string
  description = "CIDR Block for VPC"
}

variable "private_subnets_cidr" {
  type        = list(string)
  description = "CIDR Block for private subnets"
}

variable "public_subnets_cidr" {
  type        = list(string)
  description = "CIDR Block for public subnets"
}

variable "instance_type_jenkins" {
  type        = string
  description = "instance_type for Jenkins-server"
}

variable "jenkins_ssh-keyname" {
  type        = string
  description = "ssh keyname for jenkins server"
}
