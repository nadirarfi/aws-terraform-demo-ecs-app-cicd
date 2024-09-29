# ========== Backend ALB Security Group ==========
module "test_app_backend_alb_security_group" {
  source                    = "../../../../modules/aws/security_group"
  name                      = ""
  description               = "Security group for ALB backend application"
  vpc_id                    = data.aws_ssm_parameter.vpc_id.value
  ssm_security_group_id_key = local.env.ssm_params.app_backend_alb_sg_id

  ingress_rules = [
    {
      from_port       = 80
      to_port         = 80
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = []
    },
    {
      from_port       = 443
      to_port         = 443
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = []
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