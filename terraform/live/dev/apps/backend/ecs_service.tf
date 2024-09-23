# ========== "aws_ecs_service" ==========
module "dev_backend_ecs_service" {
  source                         = "../../../../modules/aws/ecs_service"
  depends_on = [
    module.prod_backend_ecs_task_definition
  ]  
  ecs_service_name               = local.env.app_backend_ecs_service_name
  ecs_cluster_id                 = data.aws_ssm_parameter.app_backend_ecs_cluster_id.value
  ecs_service_security_groups_id = split(",", data.aws_ssm_parameter.app_backend_ecs_sg_id.value)
  ecs_service_subnets_id         = split(",", data.aws_ssm_parameter.private_subnets_id.value)
  ecs_task_definition_name                = local.env.app_backend_ecs_task_def_name
  target_group_arn                       = data.aws_ssm_parameter.app_backend_blue_alb_target_group_arn.value
  ecs_service_desired_count              = local.env.app_backend_ecs_service_desired_count
  ecs_health_check_grace_period_seconds  = local.env.app_backend_ecs_service_health_check_grace_period_seconds
  container_name                         = local.env.app_backend_ecs_task_def_container_name
  container_port                         = local.env.app_backend_port_number
  ecs_service_launch_type                = local.env.app_backend_ecs_service_launch_type
  ecs_service_deployment_controller_type = local.env.app_backend_ecs_service_deployment_controller_type
  tags                                   = {}
}
