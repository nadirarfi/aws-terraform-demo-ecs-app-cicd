resource "aws_acm_certificate" "this" {
  domain_name       = var.alb_domain_name
  validation_method = "DNS"
  subject_alternative_names = [
    var.alb_domain_name
  ]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "ssl_validation" {
  certificate_arn         = aws_acm_certificate.this.arn
  validation_record_fqdns = [for record in aws_route53_record.ssl_validation : record.fqdn]
}
