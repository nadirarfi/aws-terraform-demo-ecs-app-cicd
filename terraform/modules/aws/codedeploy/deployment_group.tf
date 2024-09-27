
# ------- Create Deployment Groups for Each Environment Dynamically -------
resource "aws_codedeploy_deployment_group" "this" {
  for_each = var.codedeploy_app_environments

  app_name               = aws_codedeploy_app.this.name
  deployment_config_name = var.codedeploy_app_deployment_config_name
  deployment_group_name  = "deployment-group-${each.key}"
  service_role_arn       = aws_iam_role.codedeploy_service_role.arn

  ecs_service {
    cluster_name = each.value.ecs_cluster_name
    service_name = each.value.ecs_service_name
  }

  load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns = [each.value.alb_listener_arn]
      }

      target_group {
        name = each.value.blue_target_group
      }

      target_group {
        name = each.value.green_target_group
      }
    }
  }

  # trigger_configuration {
  #   trigger_events = ["DeploymentSuccess", "DeploymentFailure"]
  #   trigger_name       = "codedeploy-trigger-${each.key}"
  #   trigger_target_arn = each.value.sns_topic_arn
  # }

  auto_rollback_configuration {
    enabled = var.codedeploy_app_auto_rollback_enabled
    events  = var.codedeploy_app_auto_rollback_events
  }

  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout = var.codedeploy_app_deployment_ready_timeout_action
    }

    terminate_blue_instances_on_deployment_success {
      action                           = var.codedeploy_app_terminate_action
      termination_wait_time_in_minutes = var.codedeploy_app_termination_wait_time
    }
  }

  deployment_style {
    deployment_option = var.codedeploy_app_deployment_option
    deployment_type   = var.codedeploy_app_deployment_type
  }

  lifecycle {
    ignore_changes = [blue_green_deployment_config]
  }
}