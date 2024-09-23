data "aws_ssm_parameter" "codepipeline_codestarconnection_arn" { name = local.shared.ssm_params.codepipeline_codestarconnection_arn }


locals {
  shared     = yamldecode(file("../../../../config/shared.yml"))
  ssm_params = local.shared.ssm_params
  cicd       = local.shared.cicd
}