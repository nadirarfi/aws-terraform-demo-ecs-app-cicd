variable "codebuild_project_name" {
  type    = string
  default = "codebuild-proejct"
}

variable "codebuild_service_role_name" {
  type    = string
  default = "codebuild-project-iam-role"
}

variable "ssm_codebuild_assumable_role_arn_key" {
  type    = string
}


variable "codebuild_ecr_repository_project_arn" {
  type    = string
  default = ""
}

variable "codebuild_timeout" {
  type    = number
  description = "10min timeout"
  default = 10 
}

# variable "codebuild_source_type" {
#   type    = string
#   default = "GITHUB"
# }

variable "codebuild_buildspec_file_path" {
  type    = string
  default = "buildspec.yml"
}

# variable "codebuild_vpc_id" {
#   type    = string
#   default = ""
# }

# variable "codebuild_subnets_id" {
#   type    = list(string)
#   default = []
# }

# variable "codebuild_security_group_ids" {
#   type    = list(string)
#   default = []
# }

variable "codebuild_log_group_name" {
  type    = string
  default = ""
}

variable "codebuild_log_stream_name" {
  type    = string
  default = ""
}

variable "codebuild_artifact_type" {
  type    = string
  default = "CODEPIPELINE"
}

variable "codebuild_source_type" {
  type    = string
  default = "CODEPIPELINE"
}

variable "codebuild_env_compute_type" {
  type    = string
  default = "BUILD_GENERAL1_SMALL"
}

variable "codebuild_env_image" {
  type    = string
  default = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
}

variable "codebuild_env_type" {
  type    = string
  default = "LINUX_CONTAINER"
}

variable "codebuild_image_pull_credentials_type" {
  type    = string
  default = "CODEBUILD"
}

variable "codebuild_service_role_permissions" {
  type = list(object({
    effect    = string
    actions   = list(string)
    resources = list(string)
  }))
  description = "Non-default permissions for the CodeBuild IAM role."
  default = []
}

variable "ssm_codebuild_project_id_key" {
  type        = string
  default     = ""
}

variable "tags" {
  description = "A map of additional tags to add to all resources."
  type        = map(string)
  default     = {}
}

variable "codebuild_env_variables" {
  type = list(
    object({
      name  = string,
      value = string
      }
    )
  )
  default = []
  }