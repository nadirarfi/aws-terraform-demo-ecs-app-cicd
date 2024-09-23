resource "aws_codebuild_project" "this" {
  name          = var.codebuild_project_name
  service_role  = aws_iam_role.codebuild_service_role.arn
  build_timeout = var.codebuild_timeout

  source {
    type      = var.codebuild_source_type
    buildspec = file("${var.codebuild_buildspec_file_path}")
  }

  artifacts {
    type = var.codebuild_artifact_type
  }

  logs_config {
    cloudwatch_logs {
      group_name  = var.codebuild_log_group_name
      stream_name = var.codebuild_log_stream_name
    }
  }

  environment {
    compute_type                = var.codebuild_env_compute_type
    image                       = var.codebuild_env_image
    type                        = var.codebuild_env_type
    image_pull_credentials_type = var.codebuild_image_pull_credentials_type

    dynamic "environment_variable" {
      for_each = var.codebuild_env_variables
      content {
        name  = environment_variable.value.name
        value = environment_variable.value.value
      }
    }

  }

  tags = merge(local.default_tags, var.tags)

}

# ========== SSM Parameters ==========
resource "aws_ssm_parameter" "codebuild_project_id" {
  type  = "String"
  name  = var.ssm_codebuild_project_id_key
  value = aws_codebuild_project.this.id
}
