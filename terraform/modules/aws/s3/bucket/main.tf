# ========== S3 Bucket ==========


resource "aws_s3_bucket" "s3_bucket" {
  acl           = var.acl
  bucket        = var.bucket_name
  force_destroy = var.force_destroy
  tags          = merge(local.default_tags, var.tags)
}