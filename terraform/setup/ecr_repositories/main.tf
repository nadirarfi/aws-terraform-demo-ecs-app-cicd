
module "ecr_backend_repository" {
  source                     = "../../../../modules/aws/ecr"
  force_delete               = true
  ecr_repository_name        = local.shared.cicd.ecr_backend_repository_name
  ssm_ecr_repository_arn_key = local.shared.ssm_params.ecr_backend_repository_arn
  ssm_ecr_repository_url_key = local.shared.ssm_params.ecr_backend_repository_url
  tags                       = {}
}

