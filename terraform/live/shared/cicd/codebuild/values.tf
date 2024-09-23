data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_ssm_parameter" "ecr_backend_repository_url" { name = local.shared.ssm_params.ecr_backend_repository_url }
data "aws_ssm_parameter" "dev_app_backend_ecs_task_def_role_arn" { name = local.dev.ssm_params.app_backend_ecs_task_def_role_arn }
data "aws_ssm_parameter" "dev_app_backend_ecs_task_def_execution_role_arn" { name = local.dev.ssm_params.app_backend_ecs_task_def_execution_role_arn }
data "aws_ssm_parameter" "dev_app_backend_ecs_task_def_arn" { name = local.dev.ssm_params.app_backend_ecs_task_def_arn }
data "aws_ssm_parameter" "prod_app_backend_ecs_task_def_role_arn" { name = local.prod.ssm_params.app_backend_ecs_task_def_role_arn }
data "aws_ssm_parameter" "prod_app_backend_ecs_task_def_execution_role_arn" { name = local.prod.ssm_params.app_backend_ecs_task_def_execution_role_arn }
data "aws_ssm_parameter" "prod_app_backend_ecs_task_def_arn" { name = local.prod.ssm_params.app_backend_ecs_task_def_arn }


locals {
  shared = yamldecode(file("../../../../config/shared.yml"))
  dev    = yamldecode(file("../../../../config/dev.yml"))
  prod   = yamldecode(file("../../../../config/prod.yml"))
  cicd   = local.shared.cicd
}

