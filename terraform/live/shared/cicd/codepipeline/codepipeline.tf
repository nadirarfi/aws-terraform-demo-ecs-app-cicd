# ========== "aws_codepipeline" ==========
module "aws_codepipeline" {
  source                               = "../../../../modules/aws/codepipeline"
  codepipeline_name                    = local.cicd.codepipeline_name
  codepipeline_artifact_s3_bucket_name = "${local.cicd.codepipeline_name}-artifact-bucket"

  ##############################################################################
  ########################## Source Stage
  ##############################################################################
  codepipeline_source_stage_config = {
    stage_name  = "SOURCE_STAGE"
    action_name = "Sourcetest"
    output_artifacts = [
      local.cicd.codepipeline_source_stage_artifact_name
    ]
    repo_owner             = local.cicd.codepipeline_github_repo_owner
    repo_name              = local.cicd.codepipeline_github_repo_name
    repo_branch            = local.cicd.codepipeline_github_repo_branch
    codestarconnection_arn = data.aws_ssm_parameter.codepipeline_codestarconnection_arn.value
  }

  ##############################################################################
  ########################## Build Stage
  ##############################################################################
  codepipeline_build_stage_config = {
    stage_name = "BUILD_STAGE"
    actions = [
      ########################## Codebuild Project - Backend - TEST
      {
        action_name      = "BUILD_BACKEND"
        project_name     = local.cicd.codebuild_backend_project_name
        input_artifacts  = [local.cicd.codepipeline_source_stage_artifact_name]
        output_artifacts = [local.cicd.codepipeline_build_stage_backend_artifact_name]
      },
      ########################## Codebuild Project - Frontend - TEST
      {
        action_name      = "BUILD_FRONTEND"
        project_name     = local.cicd.codebuild_frontend_project_name
        input_artifacts  = [local.cicd.codepipeline_source_stage_artifact_name]
        output_artifacts = [local.cicd.codepipeline_build_stage_frontend_artifact_name]
      }
    ]
  }

  ##############################################################################
  ########################## Test Deploy Stage
  ##############################################################################
  codepipeline_test_deploy_stage_config = {
    stage_name = "TEST_DEPLOY_STAGE"
    actions = {
      ########################## Codedeploy App - Backend - test
      backend_deploy_config = {
        input_artifacts                   = [local.cicd.codepipeline_build_stage_backend_artifact_name]
        application_name                  = local.cicd.codedeploy_backend_app_name
        deployment_group_name             = local.cicd.codedeploy_backend_test_deployment_group_name
        task_definition_template_artifact = local.cicd.codepipeline_build_stage_backend_artifact_name
        appspec_template_artifact         = local.cicd.codepipeline_build_stage_backend_artifact_name
        action_name                       = "TEST_DEPLOY_BACKEND"
        task_definition_template_path     = "test_backend_task_def.json"
        appspec_template_path             = "test_backend_appspec.yml"
      }
    }
  }

  ##############################################################################
  ########################## Prod Deploy Stage
  ##############################################################################

  codepipeline_prod_deploy_stage_config = {
    stage_name = "PROD_DEPLOY_STAGE"
    actions = {
      ########################## Codedeploy App - Backend - test
      backend_deploy_config = {
        input_artifacts                   = [local.cicd.codepipeline_build_stage_backend_artifact_name]
        application_name                  = local.cicd.codedeploy_backend_app_name
        deployment_group_name             = local.cicd.codedeploy_backend_test_deployment_group_name
        task_definition_template_artifact = local.cicd.codepipeline_build_stage_backend_artifact_name
        appspec_template_artifact         = local.cicd.codepipeline_build_stage_backend_artifact_name
        action_name                       = "PROD_DEPLOY_BACKEND"
        task_definition_template_path     = "prod_backend_task_def.json"
        appspec_template_path             = "prod_backend_appspec.yml"
      }
    }
  }

  tags = {}
}