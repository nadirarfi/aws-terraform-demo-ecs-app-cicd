# ========== "aws_security_group" ==========
module "aws_security_group" {
  source = "../../../../../modules/aws/security_group"

  name = ""
  description = ""
  vpc_id = ""
  ingress_rules = []
  egress_rules = []
  ssm_security_group_id_key = ""
  tags = {}
}
