data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_ssm_parameter" "private_subnets_id" { name = local.env.ssm_params.private_subnets_id }
data "aws_ssm_parameter" "app_backend_ecs_cluster_id" { name = local.env.ssm_params.app_backend_ecs_cluster_id }
data "aws_ssm_parameter" "ecr_backend_repository_url" { name = local.shared.ssm_params.ecr_backend_repository_url }
data "aws_ssm_parameter" "app_backend_ecs_sg_id" { name = local.env.ssm_params.app_backend_ecs_sg_id }
data "aws_ssm_parameter" "app_backend_blue_alb_target_group_arn" { name = local.env.ssm_params.app_backend_blue_alb_target_group_arn }

# data "aws_ssm_parameter" "app_backend_ecs_task_def_arn" { name = local.env.ssm_params.app_backend_ecs_task_def_arn }

# data "aws_ecs_task_definition" "app_backend_ecs_task_def" { task_definition = local.env.app_backend_ecs_task_def_name }

# Get the latest revision of the ECS task definition using the family name
# data "aws_ecs_task_definition" "dev_app_backend_ecs_task_def_arn" { task_definition = . }


locals {
  shared = yamldecode(file("../../../../config/shared.yml"))
  env    = yamldecode(file("../../../../config/dev.yml"))
}