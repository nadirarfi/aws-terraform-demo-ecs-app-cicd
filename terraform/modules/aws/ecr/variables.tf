variable "ecr_repository_name" {
  type    = string
  default = ""
}

variable "force_delete" {
  type    = bool
  default = true
}

variable "ssm_ecr_repository_url_key" {
  type    = string
  default = ""
}

variable "ssm_ecr_repository_arn_key" {
  type    = string
  default = ""
}

variable "tags" {
  description = "A map of additional tags to add to all resources."
  type        = map(string)
  default     = {}
}
