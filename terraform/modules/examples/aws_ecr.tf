# ========== "aws_ecr" ==========
module "aws_ecr" {
  source = "../../../../../modules/aws/ecr"

  ecr_repository_name = ""
  force_delete = true
  ssm_ecr_repository_url_key = ""
  ssm_ecr_repository_arn_key = ""
  tags = {}
}
