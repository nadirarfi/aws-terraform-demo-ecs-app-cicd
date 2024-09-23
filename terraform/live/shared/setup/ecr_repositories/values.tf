locals {
  shared     = yamldecode(file("../../../../config/shared.yml"))
  ssm_params = local.shared.ssm_params
  cicd       = local.shared.cicd
}