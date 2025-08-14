resource "aws_wafv2_web_acl" "alb_only_from_cloudfront" {
  name  = "${var.cluster_name}-only-cf"
  scope = "REGIONAL" 

  default_action {
    block {}
  }

  rule {
    name     = "allow-when-header-matches"
    priority = 0
    
    action {
      allow {}
    }
    
    statement {
      byte_match_statement {
        search_string = var.origin_header_value
        
        field_to_match {
          single_header {
            name = lower(var.origin_header_name)
          }
        }
        
        positional_constraint = "EXACTLY"
        
        text_transformation {
          priority = 0
          type     = "NONE"
        }
      }
    }
    
    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "${var.cluster_name}-allow-header"
      sampled_requests_enabled   = false
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "${var.cluster_name}-webacl"
    sampled_requests_enabled   = false
  }

  tags = {
    Name = "${var.cluster_name}-only-cf"
  }
}

resource "aws_wafv2_web_acl_association" "wafl_association_alb" {
  resource_arn = aws_lb.application_load_balancer.arn
  web_acl_arn  = aws_wafv2_web_acl.alb_only_from_cloudfront.arn
}