# ========== Frontend Codebuild Project ==========
module "codebuild_frontend" {
  source                                = "../../../../modules/aws/codebuild"
  ssm_codebuild_project_id_key          = local.shared.ssm_params.codebuild_frontend_project_id
  codebuild_project_name                = local.cicd.codebuild_frontend_project_name
  codebuild_buildspec_file_path         = "buildspecs/frontend-buildspec.yml"
  codebuild_log_group_name              = local.cicd.codebuild_frontend_log_group_name
  codebuild_log_stream_name             = local.cicd.codebuild_frontend_log_stream_name
  codebuild_timeout                     = 10
  codebuild_artifact_type               = "CODEPIPELINE"
  codebuild_source_type                 = "CODEPIPELINE"
  codebuild_env_compute_type            = "BUILD_GENERAL1_SMALL"
  codebuild_env_image                   = "aws/codebuild/amazonlinux2-x86_64-standard:5.0"
  codebuild_env_type                    = "LINUX_CONTAINER"
  codebuild_image_pull_credentials_type = "CODEBUILD"
  ssm_codebuild_assumable_role_arn_key  = local.shared.ssm_params.codebuild_frontend_assumable_role_arn


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
        "arn:aws:s3:::${local.dev.app_frontend_s3_bucket_name}",
        "arn:aws:s3:::${local.dev.app_frontend_s3_bucket_name}/*",
        "arn:aws:s3:::${local.prod.app_frontend_s3_bucket_name}",
        "arn:aws:s3:::${local.prod.app_frontend_s3_bucket_name}/*",
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
    # Application Repository Path
    {
      name  = "APP_REPOSITORY_PATH"
      value = local.cicd.app_frontend_repository_path
    },
    # DEV Environment Variables for Frontend
    {
      name  = "DEV_APP_FRONTEND_BUCKET_URI"
      value = "s3://${local.dev.app_frontend_s3_bucket_name}/"
    },
    # PROD Environment Variables for Frontend
    {
      name  = "PROD_APP_FRONTEND_BUCKET_URI"
      value = "s3://${local.prod.app_frontend_s3_bucket_name}/"
    }
  ]

  tags = {}
}