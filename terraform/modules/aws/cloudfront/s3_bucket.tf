# Create S3 Bucket for CloudFront
resource "aws_s3_bucket" "this" {
  bucket = var.cloudfront_s3_bucket_name
  force_destroy = true
  tags = var.cloudfront_tags
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id
  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
  restrict_public_buckets = true
}

# S3 Bucket Policy to allow CloudFront access
resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id
  depends_on = [
    aws_s3_bucket.this,
    aws_cloudfront_distribution.this
    ]

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
        {
        Effect = "Allow",
        Action = "s3:GetObject",
        Principal = {
            Service = "cloudfront.amazonaws.com"
        },
        Resource = [
            "${aws_s3_bucket.this.arn}/*"
        ],
        Condition = {
            StringEquals = {
            "AWS:SourceArn" = "arn:aws:cloudfront::651199910127:distribution/${aws_cloudfront_distribution.this.id}"
            }
        }
        },
        {
            Effect = "Deny",
            Principal = "*",
            Action = "s3:*",
            Resource = [
                "${aws_s3_bucket.this.arn}",
                "${aws_s3_bucket.this.arn}/*"
            ],
            Condition = {
                Bool = {
                "aws:SecureTransport" = "false"
                }
            }
        }
    ]
  })
}

resource "aws_cloudfront_origin_access_control" "this" {
  name                               = "${var.cloudfront_s3_bucket_name}-oac"
  description                        = "Origin Access Control for S3 bucket"
  origin_access_control_origin_type  = "s3"
  signing_behavior                   = "always"
  signing_protocol                   = "sigv4"
}
