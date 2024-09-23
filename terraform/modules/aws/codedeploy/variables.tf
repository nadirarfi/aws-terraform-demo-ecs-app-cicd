variable "codedeploy_app_name" {
  description = "The name of the CodeDeploy application and deployment group"
  type        = string
  default = ""
}

variable "codedeploy_app_compute_platform" {
  description = "The compute platform for CodeDeploy (e.g., ECS)"
  type        = string
  default     = "ECS"
}

variable "codedeploy_app_deployment_config_name" {
  description = "Deployment configuration name (e.g., CodeDeployDefault.ECSAllAtOnce)"
  type        = string
  default     = "CodeDeployDefault.ECSAllAtOnce"
}


variable "codedeploy_app_environments" {
  description = "A map of environments with their specific details"
  type = map(object({
    ecs_cluster_name    = string
    ecs_service_name    = string
    alb_listener_arn   = string
    blue_target_group   = string
    green_target_group  = string
    sns_topic_arn       = string
  }))
  default = {
    dev = {
      ecs_cluster_name    = "dev-ecs-cluster"
      ecs_service_name    = "dev-ecs-service"
      alb_listener_arn   = "arn:aws:elasticloadbalancing:region:account-id:listener/app/dev-load-balancer/xyz"
      blue_target_group   = "dev-blue-target-group"
      green_target_group  = "dev-green-target-group"
      sns_topic_arn       = "arn:aws:sns:region:account-id:dev-topic"
    }
    prod = {
      ecs_cluster_name    = "prod-ecs-cluster"
      ecs_service_name    = "prod-ecs-service"
      alb_listener_arn   = "arn:aws:elasticloadbalancing:region:account-id:listener/app/prod-load-balancer/abc"
      blue_target_group   = "prod-blue-target-group"
      green_target_group  = "prod-green-target-group"
      sns_topic_arn       = "arn:aws:sns:region:account-id:prod-topic"
    }
  }
}

variable "codedeploy_app_auto_rollback_enabled" {
  description = "Enable or disable automatic rollback"
  type        = bool
  default     = true
}

variable "codedeploy_app_auto_rollback_events" {
  description = "Auto rollback events to trigger rollback"
  type        = list(string)
  default     = ["DEPLOYMENT_FAILURE"]
}

variable "codedeploy_app_deployment_ready_timeout_action" {
  description = "Action to take when the deployment is ready (e.g., CONTINUE_DEPLOYMENT)"
  type        = string
  default     = "CONTINUE_DEPLOYMENT"
}

variable "codedeploy_app_terminate_action" {
  description = "Action to take when terminating the blue instances"
  type        = string
  default     = "TERMINATE"
}

variable "codedeploy_app_termination_wait_time" {
  description = "Time to wait in minutes before terminating blue instances"
  type        = number
  default     = 5
}

variable "codedeploy_app_deployment_option" {
  description = "Deployment option (e.g., WITH_TRAFFIC_CONTROL)"
  type        = string
  default     = "WITH_TRAFFIC_CONTROL"
}

variable "codedeploy_app_deployment_type" {
  description = "Deployment type (e.g., BLUE_GREEN)"
  type        = string
  default     = "BLUE_GREEN"
}

# # variable "codedeploy_app_trigger_name" {
# #   description = "Name of the deployment trigger"
# #   type        = string
# #   default = ""
# # }

# # variable "codedeploy_app_trigger_events" {
# #   description = "Events that trigger deployment notifications"
# #   type        = list(string)
# #   default     = ["DeploymentSuccess", "DeploymentFailure"]
# # }

# # variable "codedeploy_app_sns_topic_arn" {
# #   description = "SNS topic ARN for deployment notifications"
# #   type        = string
# # }
