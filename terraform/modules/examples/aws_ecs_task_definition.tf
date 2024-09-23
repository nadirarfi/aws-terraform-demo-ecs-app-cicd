# ========== "aws_ecs_task_definition" ==========
module "aws_ecs_task_definition" {
  source = "../../../../../modules/aws/ecs_task_definition"

  ecs_task_ecr_image_repository_url = ""
  ecs_task_ecr_image_tag = "latest"
  ecs_task_name = "ecs-task-name"
  ecs_task_container_name = ""
  ecs_task_container_port = 80
  ecs_task_health_check_container_port = 80
  ecs_task_health_check_container_path = "/health/status"
  ecs_task_cpu = 256 # Adjust based on your needs
  ecs_task_memory = 512  # Adjust based on your needs
  ecs_task_execution_role_name = ""
  ecs_task_role_statements = []
  ecs_task_execution_role_statements = []
  ecs_task_role_name = ""
  ecs_task_log_group_name = ""
  ecs_task_log_stream_prefix = ""
  ecs_task_environment_variables = []
  ssm_ecs_task_definition_arn_key = ""
  ssm_ecs_task_definition_role_arn_key = ""
  ssm_ecs_task_definition_execution_role_arn_key = ""
  tags = {}
}
