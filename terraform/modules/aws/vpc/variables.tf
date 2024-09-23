# ========== Variables ==========

variable "cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "public_subnets" {
  description = "List of public subnets with availability zone and CIDR block."
  type = list(object({
    availability_zone = string
    cidr_block        = string
  }))
}

variable "private_subnets" {
  description = "List of private subnets with availability zone and CIDR block."
  type = list(object({
    availability_zone = string
    cidr_block        = string
  }))
}

variable "enable_internet_gateway" {
  description = "Boolean to create an Internet Gateway"
  type        = bool
  default     = true
}

variable "enable_nat_gateway" {
  description = "Boolean to create a NAT Gateway"
  type        = bool
  default     = true
}

variable "ssm_vpc_id_key" {
  type = string
}

variable "ssm_public_subnets_id_key" {
  type = string
}

variable "ssm_private_subnets_id_key" {
  type = string
}

variable "tags" {
  description = "A map of additional tags to add to all resources."
  type        = map(string)
  default     = {}
}