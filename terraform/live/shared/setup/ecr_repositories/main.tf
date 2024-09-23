
module "ecr_backend_repository" {
  source                     = "../../../../modules/aws/ecr"
  ecr_repository_name        = local.cicd.ecr_backend_repository_name
  force_delete               = true
  ssm_ecr_repository_arn_key = local.shared.ssm_params.ecr_backend_repository_arn
  ssm_ecr_repository_url_key = local.shared.ssm_params.ecr_backend_repository_url
  tags                       = {}
}

