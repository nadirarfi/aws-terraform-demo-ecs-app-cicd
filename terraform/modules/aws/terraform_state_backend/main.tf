# https://www.terraform.io/docs/backends/types/s3.html#dynamodb_table

##### DynamoDB Table

resource "aws_dynamodb_table" "this" {
  name         = var.tf_state_dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  server_side_encryption {
    enabled = true
  }
  point_in_time_recovery {
    enabled = true
  }
  attribute {
    name = "LockID"
    type = "S"
  }
  tags                 = merge(local.default_tags, var.tags)
}

##### S3 Bucket
resource "aws_s3_bucket" "this" {
  bucket = var.tf_state_s3_bucket_name
  tags                 = merge(local.default_tags, var.tags)
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.this.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "this" {
  bucket     = aws_s3_bucket.this.id
  acl        = "private"
  depends_on = [aws_s3_bucket_ownership_controls.this]
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "this" {
  depends_on = [aws_s3_bucket_public_access_block.this]
  bucket     = aws_s3_bucket.this.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowSSLRequestsOnly",
        Effect    = "Deny",
        Principal = "*",
        Action    = "s3:*",
        Resource = [
          "${aws_s3_bucket.this.arn}",
          "${aws_s3_bucket.this.arn}/*"
        ],
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      },
      {
        Sid       = "DenyDeleteObjectVersion",
        Effect    = "Deny",
        Principal = "*",
        Action    = "s3:DeleteObjectVersion",
        Resource = [
          "${aws_s3_bucket.this.arn}/*"
        ]
      }
    ]
  })

}