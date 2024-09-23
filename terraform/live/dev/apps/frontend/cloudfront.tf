module "cloudfront_distribution" {
  source = "../../../../modules/aws/cloudfront"
  providers = {
    aws           = aws           # Use default provider for resources in default region
    aws.us_east_1 = aws.us_east_1 # Use us-east-1 provider for CloudFront/ACM
  }
  # Domain aliases for the CloudFront distribution
  cloudfront_main_domain_name = local.env.app_domain_name
  cloudfront_aliases = [
    local.env.app_domain_name,
  ]

  # Domain names for the SSL certificate
  cloudfront_alternative_domain_names = [
    local.env.app_domain_name
  ]

  # ALB settings
  cloudfront_alb_dns_name          = local.env.app_backend_domain_name
  cloudfront_alb_origin_http_port  = 80
  cloudfront_alb_origin_https_port = 443
  cloudfront_alb_origin_id         = "alb-origin"

  # S3 bucket for static files
  cloudfront_s3_bucket_name = local.env.app_frontend_s3_bucket_name
  cloudfront_s3_origin_id   = "s3-origin"

  # Route 53 zone ID for SSL validation
  cloudfront_route53_zone_name = local.shared.aws_route53_dns_zone_name

  # Default cache behavior for static files (S3)
  cloudfront_default_cache_behavior = {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "s3-origin"
    min_ttl          = 0
    default_ttl      = 3600
    max_ttl          = 86400
  }

  # Cache behavior for backend API (ALB)
  cloudfront_cache_behavior_for_backend = {
    path_pattern     = "/api/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "DELETE", "PATCH"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "alb-origin"
    min_ttl          = 0
    default_ttl      = 0
    max_ttl          = 86400
    forward_cookies  = "all"
  }

  # Viewer protocol policy (redirect to HTTPS)
  cloudfront_viewer_protocol_policy = "redirect-to-https"

  # Geo restrictions (none by default)
  cloudfront_geo_restriction_type      = "none"
  cloudfront_geo_restriction_locations = []

  # Tags for CloudFront resources
  cloudfront_tags = {}

}
