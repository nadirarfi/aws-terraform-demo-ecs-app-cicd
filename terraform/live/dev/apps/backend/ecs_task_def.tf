# ========== "aws_ecs_task_definition" ==========

module "dev_backend_ecs_task_definition" {
  source                                         = "../../../../modules/aws/ecs_task_definition"
  ecs_task_ecr_image_repository_url              = data.aws_ssm_parameter.ecr_backend_repository_url.value
  ecs_task_name                                  = local.env.app_backend_ecs_task_def_name
  ecs_task_container_name                        = local.env.app_backend_ecs_task_def_container_name
  ecs_task_container_port                        = local.env.app_backend_port_number
  ecs_task_health_check_container_port           = local.env.app_backend_health_check_port_number
  ecs_task_health_check_container_path           = local.env.app_backend_health_check_path
  ecs_task_cpu                                   = local.env.app_backend_ecs_task_def_cpu
  ecs_task_memory                                = local.env.app_backend_ecs_task_def_memory
  ecs_task_log_group_name                        = local.env.app_backend_ecs_task_def_log_group_name
  ecs_task_log_stream_prefix                     = local.env.app_backend_ecs_task_def_log_stream_prefix
  ssm_ecs_task_definition_arn_key                = local.env.ssm_params.app_backend_ecs_task_def_arn
  ssm_ecs_task_definition_role_arn_key           = local.env.ssm_params.app_backend_ecs_task_def_role_arn
  ssm_ecs_task_definition_execution_role_arn_key = local.env.ssm_params.app_backend_ecs_task_def_execution_role_arn

  ecs_task_role_statements = [
    {
      sid    = "AllowOperationsToDynamoDBTable"
      effect = "Allow"
      actions = [
        "dynamodb:BatchGetItem",
        "dynamodb:Describe*",
        "dynamodb:List*",
        "dynamodb:GetItem",
        "dynamodb:Query",
        "dynamodb:Scan",
        "dynamodb:PutItem"
      ]
      resources = [
        "*"
      ]
    }
  ]
  ecs_task_environment_variables = [
    {
      name  = "AWS_REGION"
      value = local.shared.aws_region_name
    },
    {
      name  = "DYNAMODB_TABLE_NAME"
      value = local.env.app_backend_dynamodb_table_name
    }
  ]


  tags = {}
}
