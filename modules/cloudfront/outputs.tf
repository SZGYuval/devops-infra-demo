output "distribution_id" {
  value = aws_cloudfront_distribution.application_load_balancer_distribution.id
}

output "domain_name" {
  description = "HTTPS entrypoint"
  value = aws_cloudfront_distribution.application_load_balancer_distribution.domain_name
}