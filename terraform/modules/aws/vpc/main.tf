###################################################
############# VPC Module
###################################################

# ========== VPC Creation ==========
resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags                 = merge(local.default_tags, var.tags)
}

# ========== Public Subnets ==========
resource "aws_subnet" "public_subnets" {
  for_each                = { for idx, subnet in var.public_subnets : idx => subnet }
  availability_zone       = each.value.availability_zone
  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value.cidr_block
  map_public_ip_on_launch = true
  tags                    = merge(local.default_tags, var.tags)

}

# ========== Private Subnets ==========
resource "aws_subnet" "private_subnets" {
  for_each          = { for idx, subnet in var.private_subnets : idx => subnet }
  availability_zone = each.value.availability_zone
  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value.cidr_block
  tags              = merge(local.default_tags, var.tags)
}

# ========== Internet Gateway (Conditional) ==========
resource "aws_internet_gateway" "this" {
  count  = var.enable_internet_gateway ? 1 : 0
  vpc_id = aws_vpc.this.id
  tags   = merge(local.default_tags, var.tags)
}

# ========== NAT Gateway (Conditional) ==========
resource "aws_eip" "this" {
  count = var.enable_nat_gateway ? 1 : 0
  vpc   = true
  tags  = merge(local.default_tags, var.tags)
}

resource "aws_nat_gateway" "this" {
  count         = var.enable_nat_gateway ? 1 : 0
  allocation_id = aws_eip.this[count.index].id
  subnet_id     = aws_subnet.public_subnets[0].id
  tags          = merge(local.default_tags, var.tags)
}

# ========== Create Public Route Public Table ==========
resource "aws_route_table" "rt_public" {
  vpc_id = aws_vpc.this.id
  dynamic "route" {
    for_each = var.enable_internet_gateway ? [1] : []
    content {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.this[0].id
    }
  }
  tags = merge(local.default_tags, var.tags)
}

# ========== Create Private Route Private Table ==========
resource "aws_route_table" "rt_private" {
  vpc_id = aws_vpc.this.id
  dynamic "route" {
    for_each = var.enable_nat_gateway ? [1] : []
    content {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_nat_gateway.this[0].id
    }
  }
  tags = merge(local.default_tags, var.tags)
}

# ========== Public Subnets Association ==========
resource "aws_route_table_association" "rt_assoc_pub_subnets" {
  for_each       = aws_subnet.public_subnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.rt_public.id
}

# ========== Private Subnets Association ==========
resource "aws_route_table_association" "rt_assoc_priv_subnets" {
  for_each       = aws_subnet.private_subnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.rt_private.id
}


# ========== SSM Parameters ==========
resource "aws_ssm_parameter" "vpc_id" {
  type  = "String"
  name  = var.ssm_vpc_id_key
  value = aws_vpc.this.id
}

resource "aws_ssm_parameter" "private_subnets_id" {
  type  = "String"
  name  = var.ssm_private_subnets_id_key
  value = join(",", values(aws_subnet.private_subnets)[*].id)
}

resource "aws_ssm_parameter" "public_subnets_id" {
  type  = "String"
  name  = var.ssm_public_subnets_id_key
  value = join(",", values(aws_subnet.public_subnets)[*].id)
}
