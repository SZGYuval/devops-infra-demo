variable "alb_dns_name" {
  description = "DNS name of the application load balancer"
  type = string
}

variable "comment" {
  type = string
  default = "CloudFront in front of ALB"
}

variable "allowed_methods" {
  description = "web methods to be allowed in the distribution"
  type = list(string)
  default = ["GET", "HEAD", "OPTIONS", "PUT", "PATCH", "POST", "DELETE"]
}

variable "cached_methods" {
  description = "web methods that can be cached"  
  type = list(string)
  default = ["GET", "HEAD"]
}

variable "header_name" {
  description = "name of the header to be passed from cloudfront distribution"
  type = string
  default = "cloudfront-origin"
}

variable "distribution_name" {
  description = "name for the cloudfront distribution"
  type = string
  default = "counter-service-distribution"
}

variable "origin_name" {
  description = "identification of the origin"
  type = string
  default = "alb-origin"
}