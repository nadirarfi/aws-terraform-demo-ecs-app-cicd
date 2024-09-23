variable "ecs_task_ecr_image_repository_url" {
  description = "The ECR repository URL for the container image."
  type        = string
  default = ""
}

variable "ecs_task_ecr_image_tag" {
  description = ""
  type        = string
  default = "latest"
}

variable "ecs_task_name" {
  description = "The name of the ECS task family."
  type        = string
  default = "ecs-task-name"
}

variable "ecs_task_container_name" {
  description = "The name of the container in the task."
  type        = string
  default = ""
}

variable "ecs_task_container_port" {
  description = "The port on which the container listens."
  type        = number
  default = 80
}

variable "ecs_task_health_check_container_port" {
  description = ""
  type        = number
  default = 80
}

variable "ecs_task_health_check_container_path" {
  description = ""
  type        = string
  default = "/health/status"
}


variable "ecs_task_cpu" {
  description = "The number of CPU units used by the task."
  type        = number
  default     = 256 # Adjust based on your needs
}

variable "ecs_task_memory" {
  description = "The amount of memory (in MiB) used by the task."
  type        = number
  default     = 512  # Adjust based on your needs
}

variable "ecs_task_execution_role_name" {
  description = "The name of the IAM execution role for the ECS task."
  type        = string
  default = ""
}




variable "ecs_task_role_statements" {
  description = ""
  type        = list
  default = []
}

variable "ecs_task_execution_role_statements" {
  description = ""
  type        = list
  default = []
}


variable "ecs_task_role_name" {
  description = "The name of the IAM task role for the ECS task."
  type        = string
  default = ""
}

variable "ecs_task_log_group_name" {
  description = "The name of the CloudWatch log group."
  type        = string
  default = ""
}

variable "ecs_task_log_stream_prefix" {
  description = "Prefix for the log stream in CloudWatch."
  type        = string
  default = ""
}

variable "ecs_task_environment_variables" {
  description = "List of environment variables for the ECS container."
  type        = list(object({
    name  = string
    value = string
  }))
  default     = []
}

variable "ssm_ecs_task_definition_arn_key" {
  description = ""
  type        = string
  default = ""
}

variable "ssm_ecs_task_definition_role_arn_key" {
  description = ""
  type        = string
  default = ""
}

variable "ssm_ecs_task_definition_execution_role_arn_key" {
  description = ""
  type        = string
  default = ""
}

variable "tags" {
  description = "A map of tags to apply to all resources."
  type        = map(string)
  default     = {}
}

