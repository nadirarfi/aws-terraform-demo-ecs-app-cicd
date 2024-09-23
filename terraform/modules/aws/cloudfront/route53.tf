# ========== Route53 ==========
data "aws_route53_zone" "this" {
  name         = var.cloudfront_route53_zone_name
  private_zone = false
}

# Create Route 53 DNS validation records 
resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.this.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  zone_id = data.aws_route53_zone.this.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = 60
  records = [each.value.record]
}

resource "aws_route53_record" "frontend_alias_record" {
    depends_on = [
     aws_cloudfront_distribution.this   
    ]
  zone_id = data.aws_route53_zone.this.zone_id
  name    = var.cloudfront_main_domain_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.this.domain_name
    zone_id                = "Z2FDTNDATAQYW2"  # This is the fixed hosted zone ID for CloudFront.
    evaluate_target_health = false
  }
}