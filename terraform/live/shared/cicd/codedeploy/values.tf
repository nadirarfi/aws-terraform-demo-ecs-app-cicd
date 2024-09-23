data "aws_ssm_parameter" "dev_app_backend_alb_listeners_arns" { name = local.dev.ssm_params.app_backend_alb_listeners_arns }
# data "aws_ssm_parameter" "dev_app_backend_alb_https_listener_arn" { name = local.dev.ssm_params.app_backend_alb_https_listener_arn }
data "aws_ssm_parameter" "prod_app_backend_alb_https_listener_arn" { name = local.prod.ssm_params.app_backend_alb_https_listener_arn }

locals {
  shared = yamldecode(file("../../../../config/shared.yml"))
  dev    = yamldecode(file("../../../../config/dev.yml"))
  prod   = yamldecode(file("../../../../config/prod.yml"))
  cicd   = local.shared.cicd
}
