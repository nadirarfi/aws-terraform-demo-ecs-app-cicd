
variable "codepipeline_name" {
  description = "The name of the AWS CodePipeline."
  type        = string
}

variable "codepipeline_type" {
  description = "Type of AWS CodePipeline."
  type        = string
  default = "V2"
}


variable "codepipeline_artifact_s3_bucket_name" {
  description = "The name of the S3 bucket used to store CodePipeline artifacts."
  type        = string
}

variable "codepipeline_source_stage_config" {
  type = object({
    stage_name      = string
    action_name     = string
    repo_owner      = string  # GitHub repository owner (username or org)
    repo_name       = string  # GitHub repository name
    repo_branch     = string  # Branch name (e.g., main, develop)
    codestarconnection_arn = string
    output_artifacts = list(string)
  })
  default = {
    stage_name      = "SourceStage"
    action_name     = "Source"
    repo_owner      = "your-github-username"
    repo_name       = "your-repo"
    repo_branch     = "main"
    codestarconnection_arn = ""
    output_artifacts = ["source_output"]
  }
}

variable "codepipeline_build_stage_config" {
  type = object({
    stage_name = string
    actions = list(object({
      project_name     = string
      action_name = string
      input_artifacts  = list(string)
      output_artifacts = list(string)
    }))
  })
  description = "Configuration for the build stage with multiple actions, including project names and artifacts"
  default = {
    stage_name = "TEST_BUILD_STAGE"
    actions = [
      {
        project_name     = "my-build-project-1"
        action_name = ""
        input_artifacts  = ["SourceArtifact1"]
        output_artifacts = ["BuildArtifact1"]
      },
      {
        project_name     = "my-build-project-2"
        action_name = ""
        input_artifacts  = ["SourceArtifact2"]
        output_artifacts = ["BuildArtifact2"]
      }
    ]
  }
}

variable "codepipeline_test_deploy_stage_config" {
  description = "Configuration for the deploy stage in CodePipeline"

  type = object({
    stage_name = string
    actions = map(object({
      action_name                        = string
      input_artifacts                    = list(string)
      application_name                   = string
      deployment_group_name              = string
      task_definition_template_artifact  = string
      task_definition_template_path      = string
      appspec_template_artifact          = string
      appspec_template_path              = string
    }))
  })

  default = {
    stage_name = "TEST_DEPLOY_STAGE"
    actions = {
      deploy_action_1 = {
        action_name                        = "DeployApp1"
        input_artifacts = ["BuildArtifactApp1"]
        application_name                   = "MyApp1"
        deployment_group_name              = "MyApp1DeploymentGroup"
        task_definition_template_artifact  = "BuildArtifactApp1"
        task_definition_template_path      = "imagedefinitions1.json"
        appspec_template_artifact          = "BuildArtifactApp1"
        appspec_template_path              = "appspec1.yaml"
      }
    }
  }


}


variable "codepipeline_prod_deploy_stage_config" {
  description = "Configuration for the prod deploy stage in CodePipeline"
  type = object({
    stage_name = string
    actions = map(object({
      action_name                        = string
      input_artifacts                    = list(string)
      application_name                   = string
      deployment_group_name              = string
      task_definition_template_artifact  = string
      task_definition_template_path      = string
      appspec_template_artifact          = string
      appspec_template_path              = string
    }))
  })

  default = {
    stage_name = "PROD_DEPLOY_STAGE"
    actions = {
      deploy_action_1 = {
        action_name                        = "DeployApp1"
        input_artifacts = ["BuildArtifactApp1"]
        application_name                   = "MyApp1"
        deployment_group_name              = "MyApp1DeploymentGroup"
        task_definition_template_artifact  = "BuildArtifactApp1"
        task_definition_template_path      = "imagedefinitions1.json"
        appspec_template_artifact          = "BuildArtifactApp1"
        appspec_template_path              = "appspec1.yaml"
      }
    }
  }
}

variable "tags" {
  description = "A map of tags to apply to the resources."
  type        = map(string)
  default     = {}
}

