
# CloudFront Distribution
resource "aws_cloudfront_distribution" "this" {
    depends_on = [
        aws_acm_certificate.this,
        aws_acm_certificate_validation.this
    ]

  origin {
    domain_name              = aws_s3_bucket.this.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.this.id
    origin_id                = var.cloudfront_s3_origin_id
  }

  origin {
    domain_name = var.cloudfront_alb_dns_name
    origin_id   = var.cloudfront_alb_origin_id

    custom_origin_config {
      http_port              = var.cloudfront_alb_origin_http_port
      https_port             = var.cloudfront_alb_origin_https_port
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  enabled             = true
  is_ipv6_enabled     = false
  default_root_object = "index.html"

  aliases = var.cloudfront_aliases

  default_cache_behavior {
    target_origin_id       = var.cloudfront_default_cache_behavior.target_origin_id
    viewer_protocol_policy = var.cloudfront_viewer_protocol_policy

    allowed_methods  = var.cloudfront_default_cache_behavior.allowed_methods
    cached_methods   = var.cloudfront_default_cache_behavior.cached_methods

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    min_ttl     = var.cloudfront_default_cache_behavior.min_ttl
    default_ttl = var.cloudfront_default_cache_behavior.default_ttl
    max_ttl     = var.cloudfront_default_cache_behavior.max_ttl
  }

  ordered_cache_behavior {
    path_pattern           = var.cloudfront_cache_behavior_for_backend.path_pattern
    target_origin_id       = var.cloudfront_cache_behavior_for_backend.target_origin_id
    viewer_protocol_policy = var.cloudfront_viewer_protocol_policy

    allowed_methods  = var.cloudfront_cache_behavior_for_backend.allowed_methods
    cached_methods   = var.cloudfront_cache_behavior_for_backend.cached_methods

    forwarded_values {
      query_string = true
      cookies {
        forward = var.cloudfront_cache_behavior_for_backend.forward_cookies
      }
    }

    min_ttl     = var.cloudfront_cache_behavior_for_backend.min_ttl
    default_ttl = var.cloudfront_cache_behavior_for_backend.default_ttl
    max_ttl     = var.cloudfront_cache_behavior_for_backend.max_ttl
  }

  restrictions {
    geo_restriction {
      restriction_type = var.cloudfront_geo_restriction_type
      locations        = var.cloudfront_geo_restriction_locations
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.this.arn
    ssl_support_method        = "sni-only"
    minimum_protocol_version  = "TLSv1.2_2021"
  }

  tags = var.cloudfront_tags
}