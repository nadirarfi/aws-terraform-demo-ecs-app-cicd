## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_codepipeline.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codepipeline) | resource |
| [aws_iam_policy.codepipeline_service_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.codepipeline_service_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.codepipeline_service_role_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_s3_bucket.artifact](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_codepipeline_artifact_s3_bucket_name"></a> [codepipeline\_artifact\_s3\_bucket\_name](#input\_codepipeline\_artifact\_s3\_bucket\_name) | The name of the S3 bucket used to store CodePipeline artifacts. | `string` | n/a | yes |
| <a name="input_codepipeline_codebuild_projects_names"></a> [codepipeline\_codebuild\_projects\_names](#input\_codepipeline\_codebuild\_projects\_names) | A set of CodeBuild project names that CodePipeline will trigger during the build stage. | `list(string)` | `[]` | no |
| <a name="input_codepipeline_name"></a> [codepipeline\_name](#input\_codepipeline\_name) | The name of the AWS CodePipeline. | `string` | n/a | yes |
| <a name="input_codepipeline_service_role_name"></a> [codepipeline\_service\_role\_name](#input\_codepipeline\_service\_role\_name) | The name of the IAM role used by CodePipeline to interact with AWS services. | `string` | n/a | yes |
| <a name="input_codepipeline_source_github_oauth_token"></a> [codepipeline\_source\_github\_oauth\_token](#input\_codepipeline\_source\_github\_oauth\_token) | The OAuth token for accessing the GitHub repository. It should be stored securely in a secrets manager. | `string` | n/a | yes |
| <a name="input_codepipeline_source_github_repo_branch"></a> [codepipeline\_source\_github\_repo\_branch](#input\_codepipeline\_source\_github\_repo\_branch) | The branch of the GitHub repository that CodePipeline should monitor for changes. | `string` | n/a | yes |
| <a name="input_codepipeline_source_github_repo_name"></a> [codepipeline\_source\_github\_repo\_name](#input\_codepipeline\_source\_github\_repo\_name) | The name of the GitHub repository that serves as the source for CodePipeline. | `string` | n/a | yes |
| <a name="input_codepipeline_source_github_repo_owner"></a> [codepipeline\_source\_github\_repo\_owner](#input\_codepipeline\_source\_github\_repo\_owner) | The owner of the GitHub repository that serves as the source for CodePipeline. | `string` | n/a | yes |
| <a name="input_codepipeline_type"></a> [codepipeline\_type](#input\_codepipeline\_type) | Type of AWS CodePipeline. | `string` | `"V2"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to apply to the resources. | `map(string)` | `{}` | no |

## Outputs

No outputs.
