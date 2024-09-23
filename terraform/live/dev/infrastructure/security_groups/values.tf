data "aws_ssm_parameter" "vpc_id" {
  name = local.env.ssm_params.vpc_id
}

locals {
  env    = yamldecode(file("../../../../config/dev.yml"))
  shared = yamldecode(file("../../../../config/shared.yml"))
}

