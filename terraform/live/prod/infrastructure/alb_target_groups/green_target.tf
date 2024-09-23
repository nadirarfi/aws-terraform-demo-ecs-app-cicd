# ========== "aws_alb_target_group" ==========
module "backend_green_target_group" {
  source = "../../../../modules/aws/alb_target_group"

  vpc_id                                            = data.aws_ssm_parameter.vpc_id.value
  alb_target_group_name                             = local.env.app_backend_green_alb_target_group_name
  alb_target_group_type                             = "ip"
  alb_target_group_port                             = local.env.app_backend_health_check_port_number
  alb_target_group_protocol                         = "HTTP"
  alb_target_group_deregistration_delay             = 5
  alb_target_group_health_check_path                = local.env.app_backend_health_check_path
  alb_target_group_health_check_interval            = 15
  alb_target_group_health_check_port                = local.env.app_backend_health_check_port_number
  alb_target_group_health_check_protocol            = "HTTP"
  alb_target_group_health_check_timeout             = 10
  alb_target_group_health_check_healthy_threshold   = 2
  alb_target_group_health_check_unhealthy_threshold = 3
  alb_target_group_health_check_matcher             = "200,301"
  ssm_alb_target_group_arn_key                      = local.env.ssm_params.app_backend_green_alb_target_group_arn
  tags                                              = {}
}
