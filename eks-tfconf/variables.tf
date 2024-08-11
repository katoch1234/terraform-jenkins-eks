variable "vpc_cidr" {
  type        = string
  description = "CIDR block for VPC"

}

variable "private_subnets_cidr" {
  type        = list(string)
  description = "CIDR Block for Private subnets"
}

variable "public_subnets_cidr" {
  type        = list(string)
  description = "CIDR blcok for Public subnets"
}