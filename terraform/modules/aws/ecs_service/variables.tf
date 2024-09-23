variable "ecs_service_name" {
  description = "The name of the ECS service."
  type        = string
  default = "ecs-service"
}

variable "ecs_cluster_id" {
  description = "The ID of the ECS cluster where the service will be deployed."
  type        = string
  default = ""
}

variable "ecs_service_security_groups_id" {
  description = "The security group IDs for the ECS service."
  type        = list(string)
  default = []
}

variable "ecs_service_subnets_id" {
  description = "The subnet IDs for the ECS service."
  type        = list(string)
  default = []
}

variable "ecs_task_definition_arn" {
  description = "The ARN of the ECS task definition to use for the service."
  type        = string
  default = ""
}

variable "target_group_arn" {
  description = "The ARN of the target group to attach to the ECS service."
  type        = string
  default = ""
}

variable "ecs_service_desired_count" {
  description = "The desired number of tasks to run in the service."
  type        = number
  default     = 1
}

variable "ecs_health_check_grace_period_seconds" {
  description = "The period in seconds for the health check grace period."
  type        = number
  default     = 15
}

variable "container_name" {
  description = "The name of the container where the load balancer will direct traffic."
  type        = string
  default = ""
}

variable "container_port" {
  description = "The port number on the container where the load balancer will direct traffic."
  type        = number
  default = 80
}

variable "ecs_service_launch_type" {
  description = "The launch type for the ECS service (e.g., EC2, FARGATE)."
  type        = string
  default     = "FARGATE"
}

variable "ecs_service_deployment_controller_type" {
  description = "The type of deployment controller (e.g., ECS, CODE_DEPLOY, EXTERNAL)."
  type        = string
  default     = "CODE_DEPLOY"
}

variable "tags" {
  description = "A map of additional tags to add to all resources."
  type        = map(string)
  default     = {}
}
