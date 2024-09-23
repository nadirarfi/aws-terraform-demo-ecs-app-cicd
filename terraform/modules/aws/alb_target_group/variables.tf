variable "vpc_id" {
  description = "VPC ID for the Target Group"
  type        = string
  default     = ""
}

variable "alb_target_group_name" {
  description = ""
  type        = string
  default     = ""
}

variable "alb_target_group_type" {
  description = "Target Group Type (instance, ip, lambda)"
  type        = string
  default     = "ip"
}

variable "alb_target_group_port" {
  description = ""
  type        = number
  default     = 80
}

variable "alb_target_group_protocol" {
  description = ""
  type        = string
  default     = "HTTP"
}

variable "alb_target_group_deregistration_delay" {
  description = ""
  type        = number
  default     = 5
}

variable "alb_target_group_health_check_path" {
  description = "The path in which the ALB will send health checks"
  type        = string
  default     = "/health"
}

variable "alb_target_group_health_check_interval" {
  description = ""
  type        = number
  default     = 15
}

variable "alb_target_group_health_check_port" {
  description = "The port to which the ALB will send health checks"
  type        = number
  default     = 80
}

variable "alb_target_group_health_check_protocol" {
  description = "The protocol that the target group will use"
  type        = string
  default     = "HTTP"
}

variable "alb_target_group_health_check_timeout" {
  description = ""
  type        = number
  default     = 10
}

variable "alb_target_group_health_check_healthy_threshold" {
  description = ""
  type        = number
  default     = 2
}

variable "alb_target_group_health_check_unhealthy_threshold" {
  description = ""
  type        = number
  default     = 3
}

variable "alb_target_group_health_check_matcher" {
  description = ""
  type        = string
  default     = "200,301"
}

variable "ssm_alb_target_group_arn_key" {
  description = ""
  type        = string
}

variable "tags" {
  description = "A map of additional tags to add to all resources."
  type        = map(string)
  default     = {}
}
