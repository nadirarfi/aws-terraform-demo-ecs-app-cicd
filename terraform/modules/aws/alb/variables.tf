variable "alb_name" {
  description = "A name for the target group or ALB"
  type        = string
}

variable "alb_subnets_id" {
  description = "Subnets IDs for ALB"
  type        = list(any)
  default     = []
}

variable "alb_security_groups_id" {
  description = "Security group ID for the ALB"
  type        = list(string)
  default     = []
}

variable "alb_idle_timeout" {
  description = ""
  type        = number
  default     = 30
}

variable "alb_enable_https" {
  description = "Set to true to create a HTTPS listener"
  type        = bool
  default     = false
}

variable "alb_target_group_arn" {
  description = "Set to true to create a HTTPS listener"
  type        = string
  default     = ""
}

variable "ssm_alb_https_listener_arn_key" {
  description = ""
  type        = string
}

variable "ssm_alb_listeners_arns_key" {
  description = ""
  type        = string
}

variable "alb_create_dns_record" {
  description = "Whether to create a DNS Alias record for the ALB"
  type        = bool
  default     = false
}

variable "alb_domain_name" {
  description = "The domain name for the DNS record"
  type        = string
  default     = ""
}

variable "alb_route53_dns_zone_name" {
  description = "The name of the Route 53 hosted zone (e.g., 'nadirarfi.com')"
  type        = string
  default     = ""
}

variable "tags" {
  description = "A map of additional tags to add to all resources."
  type        = map(string)
  default     = {}
}
