locals {
  env    = yamldecode(file("../../../../config/prod.yml"))
  shared = yamldecode(file("../../../../config/shared.yml"))

  public_subnets = [for subnet in local.env.vpc_public_subnets : {
    availability_zone = subnet.availability_zone
    cidr_block        = subnet.cidr_block
    }
  ]
  private_subnets = [for subnet in local.env.vpc_private_subnets : {
    availability_zone = subnet.availability_zone
    cidr_block        = subnet.cidr_block
    }
  ]

}