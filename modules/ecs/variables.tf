variable "aws_region" {
  description = "region for the infrastructure to be deployed on"
  type = string
  default = "eu-north-1"
}

variable "cluster_name" {
  description = "name of the cluster"
  type = string
  default = "counter-service-cluster"
}

variable "vpc_id" {
  description = "id of the subnet in which the cluster will be run"
  type = string
}

variable "public_subnet_ids" {
  description = "ids of the public subnets of the vpc"
  type = list(string)
}

variable "private_subnets_ids" {
  description = "ids of the private subnets of the vpc"
  type = list(string)
}

variable "ecr_repo_url" {
  description = "url of the ecr repository to pull images from"
  type = string
}

variable "container_name" {
  description = "name of the container of the application"
  type = string
  default = "counter-service-app"
}

variable "container_port" {
  description = "port that the container will listen on"
  type = number
  default = 8000
}

variable "desired_count" {
  description = "amount of containers for the application"
  type = number
  default = 2
}

variable "health_check_path" {
    description = "path for the load balancer to perform health checks"
    type = string
    default = "/"
}

variable "origin_header_name" {
  description = "header name Cloudfront sends to ALB"
  type = string
  default = "X-Origin"
}

variable "origin_header_value" {
  description = "header value CloudFront sends to ALB"
  type = string
  default = "cloudfront-origin"
}