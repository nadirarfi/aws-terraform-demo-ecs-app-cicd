# ========== "aws_ecs_service" ==========
module "aws_ecs_service" {
  source = "../../../../../modules/aws/ecs_service"

  ecs_service_name = "ecs-service"
  ecs_cluster_id = ""
  ecs_service_security_groups_id = []
  ecs_service_subnets_id = []
  ecs_task_definition_arn = ""
  target_group_arn = ""
  ecs_service_desired_count = 1
  ecs_health_check_grace_period_seconds = 15
  container_name = ""
  container_port = 80
  ecs_service_launch_type = "FARGATE"
  ecs_service_deployment_controller_type = "CODE_DEPLOY"
  tags = {}
}
