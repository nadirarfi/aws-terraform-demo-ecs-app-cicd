data "aws_ssm_parameter" "test_app_backend_alb_https_listener_arn" { name = local.test.ssm_params.app_backend_alb_https_listener_arn }
data "aws_ssm_parameter" "prod_app_backend_alb_https_listener_arn" { name = local.prod.ssm_params.app_backend_alb_https_listener_arn }

locals {
  shared = yamldecode(file("../../../../config/shared.yml"))
  test   = yamldecode(file("../../../../config/test.yml"))
  prod   = yamldecode(file("../../../../config/prod.yml"))
  cicd   = local.shared.cicd
}
