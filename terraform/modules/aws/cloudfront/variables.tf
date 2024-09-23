# Domain for SSL Certificate

variable "cloudfront_main_domain_name" {
  description = ""
  type        = string
}

variable "cloudfront_alternative_domain_names" {
  description = "List of domain names for the SSL certificate (including the main domain and any aliases)."
  type        = list(string)
}

# Validation method for ACM certificate
variable "cloudfront_acm_certificate_validation_method" {
  description = "Method to validate the ACM certificate (DNS or EMAIL)."
  type        = string
  default     = "DNS"
}

# ALB Backend API
variable "cloudfront_alb_dns_name" {
  description = "The DNS name of the ALB that CloudFront will use as the backend API origin."
  type        = string
}

variable "cloudfront_alb_origin_id" {
  description = ""
  type        = string
}

variable "cloudfront_s3_origin_id" {
  description = ""
  type        = string
}



variable "cloudfront_alb_origin_http_port" {
  description = "HTTP port for the ALB backend."
  type        = number
  default     = 80
}

variable "cloudfront_alb_origin_https_port" {
  description = "HTTPS port for the ALB backend."
  type        = number
  default     = 443
}

# S3 Static Files
variable "cloudfront_s3_bucket_name" {
  description = "The name of the S3 bucket that CloudFront will use as the static files origin."
  type        = string
}

# Cache Behaviors
variable "cloudfront_default_cache_behavior" {
  description = "Default cache behavior for CloudFront"
  type        = any
  default     = {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "s3-origin"
    min_ttl          = 0
    default_ttl      = 3600
    max_ttl          = 86400
  }
}

variable "cloudfront_cache_behavior_for_backend" {
  description = "Cache behavior for ALB backend API"
  type        = any
  default     = {
    path_pattern    = "/api/*"
    allowed_methods = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "DELETE", "PATCH"]
    cached_methods  = ["GET", "HEAD"]
    target_origin_id = "alb-origin"
    min_ttl          = 0
    default_ttl      = 0
    max_ttl          = 86400
    forward_cookies  = "all"
  }
}

# Viewer Protocol Policy
variable "cloudfront_viewer_protocol_policy" {
  description = "The viewer protocol policy (allow-all, redirect-to-https, https-only)."
  type        = string
  default     = "redirect-to-https"
}

# Aliases for CloudFront Distribution
variable "cloudfront_aliases" {
  description = "A list of domain aliases for the CloudFront distribution."
  type        = list(string)
  default     = []
}

# Geo Restrictions
variable "cloudfront_geo_restriction_type" {
  description = "The type of geo restriction (none, whitelist, blacklist)."
  type        = string
  default     = "none"
}

variable "cloudfront_geo_restriction_locations" {
  description = "A list of country codes for geo restrictions."
  type        = list(string)
  default     = []
}

variable "cloudfront_route53_zone_name" {
  description = "The Route 53 zone name where the DNS records for SSL validation should be created."
  type        = string
}

# Tags
variable "cloudfront_tags" {
  description = "Tags to associate with CloudFront distribution"
  type        = map(string)
  default     = {
    Name = "CloudFrontWithS3AndALB"
  }
}
