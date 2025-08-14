variable "aws_region" {
  description = "name of the region to deploy vpc resources on"
  type = string
  default = "eu-north-1"
}

variable "global_name" {
  description = "templating name for vpc resources"
  type = string
  default = "counter-service"
}

variable "vpc_cidr" {
  description = "cidr of the vpc"
  type = string
  default = "11.0.0.0/16"
}

variable "availability_zones" {
  description = "list of availability zones the vpc will be on"
  type = list(string)
  default = ["eu-north-1a", "eu-north-1b"]
}

variable "public_subnet_cidrs" {
  description = "cidrs of the public subnets"
  type = list(string)
  default = ["11.0.1.0/24", "11.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "cidrs of the private subnets"
  type = list(string)
  default = ["11.0.3.0/24", "11.0.4.0/24"]
}

