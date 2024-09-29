# ========== ALB Backend ==========
module "test_backend_alb" {
  source                         = "../../../../modules/aws/alb"
  alb_name                       = local.env.app_backend_alb_name
  alb_subnets_id                 = split(",", data.aws_ssm_parameter.public_subnets_id.value)
  alb_security_groups_id         = split(",", data.aws_ssm_parameter.app_backend_alb_sg_id.value)
  alb_idle_timeout               = local.env.app_backend_alb_idle_timeout
  alb_target_group_arn           = data.aws_ssm_parameter.app_backend_blue_alb_target_group_arn.value
  alb_enable_https               = true
  alb_create_dns_record          = true
  alb_domain_name                = local.env.app_backend_domain_name
  alb_route53_dns_zone_name      = local.shared.aws_route53_dns_zone_name
  ssm_alb_https_listener_arn_key = local.env.ssm_params.app_backend_alb_https_listener_arn
  ssm_alb_listeners_arns_key     = local.env.ssm_params.app_backend_alb_listeners_arns
  tags                           = {}
}