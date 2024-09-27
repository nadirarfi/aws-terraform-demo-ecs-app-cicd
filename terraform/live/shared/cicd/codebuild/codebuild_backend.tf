# ========== Backend Codebuild Project ==========
module "codebuild_backend" {
  source                                = "../../../../modules/aws/codebuild"
  ssm_codebuild_project_id_key          = local.shared.ssm_params.codebuild_backend_project_id
  codebuild_project_name                = local.cicd.codebuild_backend_project_name
  codebuild_buildspec_file_path         = "buildspecs/backend-buildspec.yml"
  codebuild_log_group_name              = local.cicd.codebuild_backend_log_group_name
  codebuild_log_stream_name             = local.cicd.codebuild_backend_log_stream_name
  codebuild_timeout                     = 10
  codebuild_artifact_type               = "CODEPIPELINE"
  codebuild_source_type                 = "CODEPIPELINE"
  codebuild_env_compute_type            = "BUILD_GENERAL1_SMALL"
  codebuild_env_image                   = "aws/codebuild/amazonlinux2-x86_64-standard:5.0"
  codebuild_env_type                    = "LINUX_CONTAINER"
  codebuild_image_pull_credentials_type = "CODEBUILD"
  ssm_codebuild_assumable_role_arn_key  = local.shared.ssm_params.codebuild_backend_assumable_role_arn

  codebuild_service_role_permissions = [
    {
      effect = "Allow"
      actions = [
        "s3:PutObject",
        "s3:GetObject",
        "s3:GetObjectVersion",
        "s3:GetBucketAcl",
        "s3:List*"
      ]
      resources = [
        "arn:aws:s3:::${local.cicd.codepipeline_name}-artifact-bucket/*",
        "arn:aws:s3:::${local.cicd.codepipeline_name}-artifact-bucket/"
      ]
    },
    {
      effect = "Allow"
      actions = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
      resources = [
        "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:*"
      ]
    },
    {
      effect = "Allow"
      actions = [
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:GetRepositoryPolicy",
        "ecr:DescribeRepositories",
        "ecr:ListImages",
        "ecr:DescribeImages",
        "ecr:BatchGetImage",
        "ecr:CompleteLayerUpload",
        "ecr:InitiateLayerUpload",
        "ecr:PutImage",
        "ecr:UploadLayerPart"
      ]
      resources = [
        "arn:aws:ecr:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:repository/*"
      ]
    },
    {
      effect = "Allow"
      actions = [
        "codestar-connections:*"
      ]
      resources = ["*"]
    },
    {
      effect = "Allow"
      actions = [
        "ssm:*"
      ]
      resources = ["*"]
    },
    {
      effect = "Allow"
      actions = [
        "ecs:DescribeServices",
        "ecs:DescribeTaskDefinition",
        "ecs:ListServices",
        "ecs:ListTasks",
        "ecs:ListTaskDefinitions",
        "ecs:DescribeTasks"
      ]
      resources = ["*"]
    }
  ]

  codebuild_env_variables = [

    # AWS Environment Variables
    {
      name  = "AWS_REGION"
      value = "${data.aws_region.current.name}"
    },
    {
      name  = "AWS_ACCOUNT_ID"
      value = data.aws_caller_identity.current.account_id
    },
    # Codebuild Assumable Role
    {
      name  = "AWS_ASSUMABLE_ROLE_ARN"
      value = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${local.cicd.codebuild_backend_project_name}-assumable-role"
    },
    # Docker Hub credentials
    {
      name  = "SSM_DOCKER_HUB_USERNAME_KEY"
      value = local.shared.ssm_params.codebuild_docker_hub_username
    },
    {
      name  = "SSM_DOCKER_HUB_PASSWORD_KEY"
      value = local.shared.ssm_params.codebuild_docker_hub_password
    },
    # ECR Repository Variables
    {
      name  = "ECR_REPOSITORY_URL"
      value = data.aws_ssm_parameter.ecr_backend_repository_url.value
    },
    # Application Repository Path
    {
      name  = "APP_REPOSITORY_PATH"
      value = local.cicd.app_backend_repository_path
    },

    # DEV Environment Variables
    {
      name  = "DEV_TASK_FAMILY"
      value = local.dev.app_backend_ecs_task_def_name
    },
    {
      name  = "DEV_SSM_TASK_DEFINITION_ARN_KEY"
      value = local.dev.ssm_params.app_backend_ecs_task_def_arn
    },
    {
      name  = "DEV_CONTAINER_NAME"
      value = local.dev.app_backend_ecs_task_def_container_name
    },
    {
      name  = "DEV_CONTAINER_PORT"
      value = local.dev.app_backend_port_number
    },
    {
      name  = "DEV_HEALTHCHECK_PATH"
      value = local.dev.app_backend_health_check_path
    },
    {
      name  = "DEV_CONTAINER_CPU"
      value = local.dev.app_backend_ecs_task_def_cpu
    },
    {
      name  = "DEV_CONTAINER_MEMORY_RESERVATION"
      value = local.dev.app_backend_ecs_task_def_memory
    },
    {
      name  = "DEV_AWSLOGS_GROUP"
      value = local.dev.app_backend_ecs_task_def_log_group_name
    },
    {
      name  = "DEV_AWSLOGS_STREAM_PREFIX"
      value = local.dev.app_backend_ecs_task_def_log_stream_prefix
    },
    {
      name  = "DEV_DYNAMODB_TABLE_NAME"
      value = local.dev.app_backend_dynamodb_table_name
    },
    {
      name  = "DEV_TASK_ROLE_ARN"
      value = data.aws_ssm_parameter.dev_app_backend_ecs_task_def_role_arn.value
    },
    {
      name  = "DEV_TASK_EXECUTION_ROLE_ARN"
      value = data.aws_ssm_parameter.dev_app_backend_ecs_task_def_execution_role_arn.value
    },
    # PROD Environment Variables
    {
      name  = "PROD_TASK_FAMILY"
      value = local.prod.app_backend_ecs_task_def_name
    },
    {
      name  = "PROD_SSM_TASK_DEFINITION_ARN_KEY"
      value = local.prod.ssm_params.app_backend_ecs_task_def_arn
    },
    {
      name  = "PROD_CONTAINER_NAME"
      value = local.prod.app_backend_ecs_task_def_container_name
    },
    {
      name  = "PROD_CONTAINER_PORT"
      value = local.prod.app_backend_port_number
    },
    {
      name  = "PROD_HEALTHCHECK_PATH"
      value = local.prod.app_backend_health_check_path
    },
    {
      name  = "PROD_CONTAINER_CPU"
      value = local.prod.app_backend_ecs_task_def_cpu
    },
    {
      name  = "PROD_CONTAINER_MEMORY_RESERVATION"
      value = local.prod.app_backend_ecs_task_def_memory
    },
    {
      name  = "PROD_AWSLOGS_GROUP"
      value = local.prod.app_backend_ecs_task_def_log_group_name
    },
    {
      name  = "PROD_AWSLOGS_STREAM_PREFIX"
      value = local.prod.app_backend_ecs_task_def_log_stream_prefix
    },
    {
      name  = "PROD_DYNAMODB_TABLE_NAME"
      value = local.prod.app_backend_dynamodb_table_name
    },
    {
      name  = "PROD_TASK_ROLE_ARN"
      value = data.aws_ssm_parameter.prod_app_backend_ecs_task_def_role_arn.value
    },
    {
      name  = "PROD_TASK_EXECUTION_ROLE_ARN"
      value = data.aws_ssm_parameter.prod_app_backend_ecs_task_def_execution_role_arn.value
    }


  ]

  tags = {}
}