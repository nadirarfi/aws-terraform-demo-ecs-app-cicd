data "aws_ssm_parameter" "vpc_id" { name = local.env.ssm_params.vpc_id }
data "aws_ssm_parameter" "public_subnets_id" { name = local.env.ssm_params.public_subnets_id }
data "aws_ssm_parameter" "app_backend_alb_sg_id" { name = local.env.ssm_params.app_backend_alb_sg_id }


locals {
  env    = yamldecode(file("../../../../config/dev.yml"))
  shared = yamldecode(file("../../../../config/shared.yml"))
}

