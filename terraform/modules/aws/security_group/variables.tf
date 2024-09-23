variable "name" {
  description = "The name of your security group"
  type        = string
}

variable "description" {
  description = "A description of the purpose"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC where the security group will take place"
  type        = string
}

variable "ingress_rules" {
  description = "List of ingress rules"
  type = list(object({
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = list(string)
    security_groups = list(string)
  }))
  default = []
}

variable "egress_rules" {
  description = "List of egress rules"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = []
}

variable "ssm_security_group_id_key" {
  type = string
}

variable "tags" {
  description = "A map of additional tags to add to all resources."
  type        = map(string)
  default     = {}
}