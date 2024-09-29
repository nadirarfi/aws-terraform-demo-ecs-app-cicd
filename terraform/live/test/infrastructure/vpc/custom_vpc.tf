# ========== test VPC ==========
module "test_vpc" {
  source = "../../../../modules/aws/vpc"

  cidr_block                 = local.env.vpc_cidr_block
  public_subnets             = local.public_subnets
  private_subnets            = local.private_subnets
  ssm_vpc_id_key             = local.env.ssm_params.vpc_id
  ssm_private_subnets_id_key = local.env.ssm_params.private_subnets_id
  ssm_public_subnets_id_key  = local.env.ssm_params.public_subnets_id
  enable_internet_gateway    = true
  enable_nat_gateway         = false
  tags                       = {}
}
