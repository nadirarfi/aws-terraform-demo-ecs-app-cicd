data "aws_ssm_parameter" "private_subnets_id" { name = local.env.ssm_params.private_subnets_id }
data "aws_ssm_parameter" "app_backend_ecs_cluster_id" { name = local.env.ssm_params.app_backend_ecs_cluster_id }
data "aws_ssm_parameter" "ecr_backend_repository_url" { name = local.shared.ssm_params.ecr_backend_repository_url }
data "aws_ssm_parameter" "app_backend_ecs_sg_id" { name = local.env.ssm_params.app_backend_ecs_sg_id }
data "aws_ssm_parameter" "app_backend_blue_alb_target_group_arn" { name = local.env.ssm_params.app_backend_blue_alb_target_group_arn }

locals {
  shared = yamldecode(file("../../../../config/shared.yml"))
  env    = yamldecode(file("../../../../config/dev.yml"))
}