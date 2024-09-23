# ------- AWS CodeDeploy App definition for each module -------
resource "aws_codedeploy_app" "this" {
  compute_platform = var.codedeploy_app_compute_platform
  name             = var.codedeploy_app_name
}

# ------- IAM Role for CodeDeploy -------
resource "aws_iam_role" "codedeploy_service_role" {
  name = "${var.codedeploy_app_name}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "codedeploy.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "codedeploy_service_role" {
  name = "${var.codedeploy_app_name}-policy"
  path = "/"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
    {
      "Action" : [
        "ecs:DescribeServices",
        "ecs:CreateTaskSet",
        "ecs:UpdateServicePrimaryTaskSet",
        "ecs:DeleteTaskSet",
        "elasticloadbalancing:DescribeTargetGroups",
        "elasticloadbalancing:DescribeListeners",
        "elasticloadbalancing:ModifyListener",
        "elasticloadbalancing:DescribeRules",
        "elasticloadbalancing:ModifyRule",
        "lambda:InvokeFunction",
        "cloudwatch:DescribeAlarms",
        "sns:Publish",
        "s3:GetObject",
        "s3:GetObjectVersion"
      ],
      "Resource" : "*",
      "Effect" : "Allow"
    },
    {
      "Action" : [
        "iam:PassRole"
      ],
      "Effect" : "Allow",
      "Resource" : "*",
      "Condition" : {
        "StringLike" : {
          "iam:PassedToService" : [
            "ecs-tasks.amazonaws.com"
          ]
        }
      }
    }
    ]
  })

  lifecycle {
    create_before_destroy = false  # Ensure that only one version of the policy exists
  }
}

resource "aws_iam_role_policy_attachment" "codedeploy_service_role" {
  role       = aws_iam_role.codedeploy_service_role.name
  policy_arn = aws_iam_policy.codedeploy_service_role.arn
}

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

# # ------- AWS CodeDeploy Deployment Group -------
# resource "aws_codedeploy_deployment_group" "this" {
#   app_name               = aws_codedeploy_app.this.name
#   deployment_config_name = var.codedeploy_app_deployment_config_name
#   deployment_group_name  = "${var.codedeploy_app_name}-deployment-group"
#   service_role_arn       = aws_iam_role.codedeploy_service_role.arn

#   auto_rollback_configuration {
#     enabled = var.codedeploy_app_auto_rollback_enabled
#     events  = var.codedeploy_app_auto_rollback_events
#   }

#   blue_green_deployment_config {
#     deployment_ready_option {
#       action_on_timeout = var.codedeploy_app_deployment_ready_timeout_action
#     }

#     terminate_blue_instances_on_deployment_success {
#       action                           = var.codedeploy_app_terminate_action
#       termination_wait_time_in_minutes = var.codedeploy_app_termination_wait_time
#     }
#   }

#   deployment_style {
#     deployment_option = var.codedeploy_app_deployment_option
#     deployment_type   = var.codedeploy_app_deployment_type
#   }

#   ecs_service {
#     cluster_name = var.codedeploy_app_ecs_cluster_name
#     service_name = var.codedeploy_app_ecs_service_name
#   }

#   load_balancer_info {
#     target_group_pair_info {
#       prod_traffic_route {
#         listener_arns = var.codedeploy_app_alb_listeners_arns
#       }

#       target_group {
#         name = var.codedeploy_app_blue_target_group
#       }

#       target_group {
#         name = var.codedeploy_app_green_target_group
#       }
#     }
#   }

#   # trigger_configuration {
#   #   trigger_events = var.codedeploy_app_trigger_events
#   #   trigger_name       = var.codedeploy_app_trigger_name
#   #   trigger_target_arn = var.codedeploy_app_sns_topic_arn
#   # }

#   lifecycle {
#     ignore_changes = [blue_green_deployment_config]
#   }
# }
