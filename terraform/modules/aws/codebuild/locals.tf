# ========== Local Default Tags ==========
locals {
  default_tags = {
    Module    = "Codebuild"
    ManagedBy = "Terraform"
  }

}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}