
variable "ecs_cluster_name" {
  description = "Name of ECS Cluster."
  type        = string
  default     = ""
}

variable "ssm_ecs_cluster_arn_key" {
  description = ""
  type        = string
  default     = ""
}

variable "ssm_ecs_cluster_id_key" {
  description = ""
  type        = string
  default     = ""
}


variable "tags" {
  description = "A map of additional tags to add to all resources."
  type        = map(string)
  default     = {}
}


