resource "aws_ecr_repository" "this" {
  name                 = var.ecr_repository_name
  image_tag_mutability = "MUTABLE"
  force_delete         = var.force_delete
  tags                 = merge(local.default_tags, var.tags)
}

# ========== SSM Parameters ==========
resource "aws_ssm_parameter" "ecr_repository_arn" {
  type  = "String"
  overwrite   = true
  name  = var.ssm_ecr_repository_arn_key
  value = aws_ecr_repository.this.arn
}

resource "aws_ssm_parameter" "ecr_repository_url" {
  type  = "String"
  overwrite   = true
  name  = var.ssm_ecr_repository_url_key
  value = aws_ecr_repository.this.repository_url
}