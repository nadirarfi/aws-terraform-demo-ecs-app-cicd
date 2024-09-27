# ========== "aws_codedeploy" ==========
module "aws_codedeploy_backend" {
  source = "../../../../modules/aws/codedeploy"

  codedeploy_app_name                            = local.cicd.codedeploy_backend_app_name
  codedeploy_app_deployment_config_name          = "CodeDeployDefault.ECSAllAtOnce"
  codedeploy_app_compute_platform                = "ECS"
  codedeploy_app_auto_rollback_enabled           = true
  codedeploy_app_auto_rollback_events            = ["DEPLOYMENT_FAILURE"]
  codedeploy_app_deployment_ready_timeout_action = "CONTINUE_DEPLOYMENT"
  codedeploy_app_terminate_action                = "TERMINATE"
  codedeploy_app_termination_wait_time           = 5
  codedeploy_app_deployment_option               = "WITH_TRAFFIC_CONTROL"
  codedeploy_app_deployment_type                 = "BLUE_GREEN"

  codedeploy_app_environments = {
    # DEV Deployment Group
    dev = {
      ecs_cluster_name   = local.dev.app_backend_ecs_cluster_name
      ecs_service_name   = local.dev.app_backend_ecs_service_name
      blue_target_group  = local.dev.app_backend_blue_alb_target_group_name
      green_target_group = local.dev.app_backend_green_alb_target_group_name
      alb_listener_arn   = data.aws_ssm_parameter.dev_app_backend_alb_https_listener_arn.value
      sns_topic_arn      = ""
    },
    # PROD Deployment Group
    prod = {
      ecs_cluster_name   = local.prod.app_backend_ecs_cluster_name
      ecs_service_name   = local.prod.app_backend_ecs_service_name
      blue_target_group  = local.prod.app_backend_blue_alb_target_group_name
      green_target_group = local.prod.app_backend_green_alb_target_group_name
      alb_listener_arn   = data.aws_ssm_parameter.prod_app_backend_alb_https_listener_arn.value
      sns_topic_arn      = ""
    }
  }
}
