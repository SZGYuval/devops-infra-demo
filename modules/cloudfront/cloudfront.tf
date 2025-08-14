resource "aws_cloudfront_cache_policy" "use_origin_cache_headers" {
  name = "use-origin-cache-headers"

  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = "none"
    }
    headers_config {
      header_behavior = "none"
    }
    query_strings_config {
      query_string_behavior = "none"
    }
  }
}

resource "aws_cloudfront_distribution" "application_load_balancer_distribution" {
  origin {
    domain_name = var.alb_dns_name
    origin_id = var.origin_name

    custom_origin_config {
      http_port = 80
      https_port = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols = ["TLSv1.2"]
    }

    custom_header {
      name = "X-Origin"
      value = var.header_name
    }
  }

  default_cache_behavior {
    target_origin_id = var.origin_name
    viewer_protocol_policy = "redirect-to-https"
    cache_policy_id = aws_cloudfront_cache_policy.use_origin_cache_headers.id
    allowed_methods = var.allowed_methods
    cached_methods = var.cached_methods
  }

  enabled = true
  is_ipv6_enabled = false
  default_root_object = ""

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  tags = {
    Name = var.distribution_name
  }
}
