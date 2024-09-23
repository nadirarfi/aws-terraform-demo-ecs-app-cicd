# ========== Application Backend Security Group ==========
module "dev_app_backend_ecs_task_security_group" {
  source                    = "../../../../modules/aws/security_group"
  name                      = ""
  description               = "Security group for backend application (ECS Tasks)"
  vpc_id                    = data.aws_ssm_parameter.vpc_id.value
  ssm_security_group_id_key = local.env.ssm_params.app_backend_ecs_sg_id

  ingress_rules = [
    {
      from_port       = local.env.app_backend_port_number
      to_port         = local.env.app_backend_port_number
      protocol        = "tcp"
      cidr_blocks     = []
      security_groups = [module.dev_app_backend_alb_security_group.id] # Allow traffic from ALB
    },
    {
      from_port       = local.env.app_backend_health_check_port_number
      to_port         = local.env.app_backend_health_check_port_number
      protocol        = "tcp"
      cidr_blocks     = []
      security_groups = [module.dev_app_backend_alb_security_group.id] # Allow traffic from ALB
    }
  ]

  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  tags = {}
}