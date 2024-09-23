# ========== Task Definition ==========
data "aws_region" "current" {}

resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "${var.ecs_task_name}-execution-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  tags = merge(local.default_tags, var.tags)

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_iam_policy_document" "ecs_task_execution_role_policy" {
  statement {
    sid = "DefaultECSExecutionRole"
    effect = "Allow"
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
      ]
    resources = ["*"]
  }
  dynamic "statement" {
    for_each = var.ecs_task_execution_role_statements
    content {
      sid    = statement.value.sid
      effect = statement.value.effect
      actions = statement.value.actions
      resources = statement.value.resources
    }
  }
}

resource "aws_iam_policy" "ecs_task_execution_role_policy" {
  name               = "${var.ecs_task_name}-execution-role-policy"
  policy      = data.aws_iam_policy_document.ecs_task_execution_role_policy.json
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.ecs_task_execution_role_policy.arn
}


#############################################################
resource "aws_iam_role" "ecs_task_role" {
  name               = "${var.ecs_task_name}-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  tags = merge(local.default_tags, var.tags)

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_iam_policy_document" "ecs_task_role_policy" {
  statement {
    sid = "DefaultECSTaskRole"
    effect = "Allow"
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
      ]
    resources = ["*"]
  }
  dynamic "statement" {
    for_each = var.ecs_task_role_statements
    content {
      sid    = statement.value.sid
      effect = statement.value.effect
      actions = statement.value.actions
      resources = statement.value.resources
    }
  }
}

resource "aws_iam_policy" "ecs_task_role_policy" {
  name               = "${var.ecs_task_name}-role-policy"
  policy      = data.aws_iam_policy_document.ecs_task_role_policy.json
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_role_policy_attachment" "ecs_task_role_policy" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = aws_iam_policy.ecs_task_role_policy.arn
}

resource "aws_cloudwatch_log_group" "this" {
  name              = var.ecs_task_log_group_name
  retention_in_days = 7

  tags = merge(local.default_tags, var.tags)
}

resource "aws_ecs_task_definition" "this" {
  family                   = var.ecs_task_name
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.ecs_task_cpu
  memory                   = var.ecs_task_memory
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn

container_definitions = jsonencode([
    {
      name                = var.ecs_task_container_name
      image               = "${var.ecs_task_ecr_image_repository_url}:${var.ecs_task_ecr_image_tag}"
      networkMode         = "awsvpc"
      cpu                 = var.ecs_task_cpu
      memoryReservation   = var.ecs_task_memory
      essential           = true
      portMappings        = [
        {
          containerPort = var.ecs_task_container_port
          hostPort      = var.ecs_task_container_port
          protocol      = "tcp"
        }
      ]
      logConfiguration    = {
        logDriver = "awslogs"
        options   = {
          awslogs-group         = var.ecs_task_log_group_name
          awslogs-stream-prefix = var.ecs_task_log_stream_prefix
          awslogs-region        = data.aws_region.current.name
        }
      }
      environment         = [
        for env_var in var.ecs_task_environment_variables : {
          name  = env_var.name
          value = env_var.value
        }
      ]
      # healthCheck         = {
      #   command     = ["CMD-SHELL", "curl -f http://localhost:${var.ecs_task_health_check_container_port}${var.ecs_task_health_check_container_path} || exit 1"]
      #   interval    = 45
      #   timeout     = 10
      #   retries     = 3
      #   startPeriod = 30
      # }
    }
  ])

}

# ========== SSM Parameters ==========
resource "aws_ssm_parameter" "ecs_task_definition_arn" {
  type  = "String"
  name  = var.ssm_ecs_task_definition_arn_key
  value = aws_ecs_task_definition.this.arn
}

resource "aws_ssm_parameter" "ecs_task_definition_role_arn" {
  type  = "String"
  name  = var.ssm_ecs_task_definition_role_arn_key
  value = aws_iam_role.ecs_task_role.arn
}

resource "aws_ssm_parameter" "ecs_task_definition_execution_role_arn" {
  type  = "String"
  name  = var.ssm_ecs_task_definition_execution_role_arn_key
  value = aws_iam_role.ecs_task_execution_role.arn
}