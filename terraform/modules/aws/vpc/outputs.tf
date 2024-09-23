# ========== Outputs ==========
output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnet_ids" {
  value = [for subnet in aws_subnet.public_subnets : subnet.id]
}

output "private_subnet_ids" {
  value = [for subnet in aws_subnet.private_subnets : subnet.id]
}

output "igw_id" {
  value = var.enable_internet_gateway ? aws_internet_gateway.this[0].id : null
}

output "natgw_id" {
  value = var.enable_nat_gateway ? aws_nat_gateway.this[0].id : null
}