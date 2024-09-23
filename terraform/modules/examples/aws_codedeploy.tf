# ========== "aws_codedeploy" ==========
module "aws_codedeploy" {
  source = "../../../../../modules/aws/codedeploy"

  codedeploy_app_name = ""
  codedeploy_app_compute_platform = "ECS"
  codedeploy_app_deployment_config_name = "CodeDeployDefault.ECSAllAtOnce"
  codedeploy_app_environments = {
  codedeploy_app_auto_rollback_enabled = true
  codedeploy_app_auto_rollback_events = ["DEPLOYMENT_FAILURE"]
  codedeploy_app_deployment_ready_timeout_action = "CONTINUE_DEPLOYMENT"
  codedeploy_app_terminate_action = "TERMINATE"
  codedeploy_app_termination_wait_time = 5
  codedeploy_app_deployment_option = "WITH_TRAFFIC_CONTROL"
  codedeploy_app_deployment_type = "BLUE_GREEN"
}
