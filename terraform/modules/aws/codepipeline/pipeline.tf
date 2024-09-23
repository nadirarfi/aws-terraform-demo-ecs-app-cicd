resource "aws_codepipeline" "this" {
  pipeline_type = var.codepipeline_type
  name     = var.codepipeline_name
  role_arn = aws_iam_role.codepipeline_service_role.arn
  execution_mode = "SUPERSEDED"

  artifact_store {
    location = var.codepipeline_artifact_s3_bucket_name
    type     = "S3"
  }

  ##############################################################################
  ########################## Triigering/Filtering Configuration
  ##############################################################################
  trigger {
    provider_type = "CodeStarSourceConnection"
    git_configuration {
      source_action_name = var.codepipeline_source_stage_config.action_name
      push {
        branches {
          includes = ["main", "develop"]
        }
        file_paths {
          includes = [
            "apps/frontend/*",
            "apps/backend/*"
          ]
        }
      }
    }
  }

  ##############################################################################
  ########################## Main Source Stage
  ##############################################################################
  stage {
    name = var.codepipeline_source_stage_config.stage_name
    action {
      name             = var.codepipeline_source_stage_config.action_name
      category         = "Source"
      owner            =  "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = var.codepipeline_source_stage_config.output_artifacts
      configuration = {
        ConnectionArn    = var.codepipeline_source_stage_config.codestarconnection_arn
        FullRepositoryId = "${var.codepipeline_source_stage_config.repo_owner}/${var.codepipeline_source_stage_config.repo_name}" # Repo in the format: owner/repo
        BranchName       = var.codepipeline_source_stage_config.repo_branch
        DetectChanges = true
        OutputArtifactFormat = "CODEBUILD_CLONE_REF" # Full clone with repo metadata
        # Git clone: The source code can be directly downloaded to the build environment.
        # The Git clone mode allows you to interact with the source code as a working Git repository.
        # To use this mode, you must grant your CodeBuild environment permissions to use the connection.
      }
    }
  }

  ##############################################################################
  ########################## Test Build Stage
  ##############################################################################
stage {
  name = var.codepipeline_build_stage_config.stage_name
  dynamic "action" {
    for_each = var.codepipeline_build_stage_config.actions
    content {
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      name             = action.value.action_name  # Directly construct the name using project_name
      input_artifacts  = action.value.input_artifacts
      output_artifacts = action.value.output_artifacts
      configuration = {
        ProjectName = action.value.project_name
      }
    }
  }
}
  ##############################################################################
  ########################## Test Deploy Stage
  ##############################################################################
  stage {
    name = var.codepipeline_test_deploy_stage_config.stage_name
    dynamic "action" {
      for_each = var.codepipeline_test_deploy_stage_config.actions
      content {
        category         = "Deploy"
        owner            = "AWS"
        provider         = "CodeDeployToECS"
        version          =  "1"
        name             = action.value.action_name
        input_artifacts  = action.value.input_artifacts
        configuration = {
          ApplicationName                = action.value.application_name
          DeploymentGroupName            = action.value.deployment_group_name
          TaskDefinitionTemplateArtifact = action.value.task_definition_template_artifact
          TaskDefinitionTemplatePath     = action.value.task_definition_template_path
          AppSpecTemplateArtifact        = action.value.appspec_template_artifact
          AppSpecTemplatePath            = action.value.appspec_template_path
        }
      }
    }
  }

  ##############################################################################
  ########################## Manual approval - Start Prod
  ##############################################################################
  stage {
    name = "MANUAL_APPROVAL"

    action {
      name       = "ManualApproval"
      category   = "Approval"
      owner      = "AWS"
      provider   = "Manual"
      version    = "1"
      configuration = {
        CustomData = "The deployment in production has to be manually approved."
      }
    }
  }

  ##############################################################################
  ########################## Prod Deploy Stage
  ##############################################################################
  stage {
    name = var.codepipeline_prod_deploy_stage_config.stage_name
    dynamic "action" {
      for_each = var.codepipeline_prod_deploy_stage_config.actions
      content {
        category         = "Deploy"
        owner            = "AWS"
        provider         = "CodeDeployToECS"
        version          =  "1"
        name             = action.value.action_name
        input_artifacts  = action.value.input_artifacts
        configuration = {
          ApplicationName                = action.value.application_name
          DeploymentGroupName            = action.value.deployment_group_name
          TaskDefinitionTemplateArtifact = action.value.task_definition_template_artifact
          TaskDefinitionTemplatePath     = action.value.task_definition_template_path
          AppSpecTemplateArtifact        = action.value.appspec_template_artifact
          AppSpecTemplatePath            = action.value.appspec_template_path
        }
      }
    }
  }



}
