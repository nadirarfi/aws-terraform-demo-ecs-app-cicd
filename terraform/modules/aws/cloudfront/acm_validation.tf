# ACM Certificate for CloudFront (us-east-1)
resource "aws_acm_certificate" "this" {
  provider                  = aws.us_east_1
  domain_name               = var.cloudfront_main_domain_name
  subject_alternative_names = var.cloudfront_alternative_domain_names
  validation_method         = "DNS"
  tags = var.cloudfront_tags
}

resource "aws_acm_certificate_validation" "this" {
  provider                  = aws.us_east_1
  certificate_arn         = aws_acm_certificate.this.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation: record.fqdn]
}
