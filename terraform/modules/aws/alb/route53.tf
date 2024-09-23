# ========== Route53 ==========
data "aws_route53_zone" "selected" {
  name         = var.alb_route53_dns_zone_name
  private_zone = false
}

resource "aws_route53_record" "alb_alias" {
  count = var.alb_create_dns_record ? 1 : 0
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = var.alb_domain_name
  type    = "A"
  alias {
    name                   = aws_alb.this.dns_name
    zone_id                = aws_alb.this.zone_id
    evaluate_target_health = true
  }
}

# ACM DNS validation via Route 53
resource "aws_route53_record" "ssl_validation" {
  for_each = {
    for dvo in aws_acm_certificate.this.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      value  = dvo.resource_record_value
    }
  }

  zone_id = data.aws_route53_zone.selected.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = 60
  records = [each.value.value]
}
