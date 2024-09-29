# ========== Target Groups for ALB ==========
resource "aws_alb_target_group" "this" {
  vpc_id               = var.vpc_id
  name                 = var.alb_target_group_name
  target_type          = var.alb_target_group_type
  port                 = var.alb_target_group_port
  protocol             = var.alb_target_group_protocol
  deregistration_delay = var.alb_target_group_deregistration_delay

  health_check {
    enabled             = true
    path                = var.alb_target_group_health_check_path
    interval            = var.alb_target_group_health_check_interval
    port                = var.alb_target_group_health_check_port
    protocol            = var.alb_target_group_health_check_protocol
    timeout             = var.alb_target_group_health_check_timeout
    healthy_threshold   = var.alb_target_group_health_check_healthy_threshold
    unhealthy_threshold = var.alb_target_group_health_check_unhealthy_threshold
    matcher             = var.alb_target_group_health_check_matcher
  }

  lifecycle {
    create_before_destroy = false
  }
}

# ========== SSM Parameters ==========
resource "aws_ssm_parameter" "this" {
  type  = "String"
  overwrite   = true
  name  = var.ssm_alb_target_group_arn_key
  value = aws_alb_target_group.this.arn
}