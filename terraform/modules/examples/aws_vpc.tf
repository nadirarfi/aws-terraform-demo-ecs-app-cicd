# ========== "aws_vpc" ==========
module "aws_vpc" {
  source = "../../../../../modules/aws/vpc"

  cidr_block = ""
  public_subnets = ""
  private_subnets = ""
  enable_internet_gateway = true
  enable_nat_gateway = true
  ssm_vpc_id_key = ""
  ssm_public_subnets_id_key = ""
  ssm_private_subnets_id_key = ""
  tags = {}
}
