
resource "aws_s3_bucket" "artifact" {
  bucket        = var.codepipeline_artifact_s3_bucket_name
  acl           = "private"
  force_destroy = true
  tags = merge(local.default_tags, var.tags)
}
