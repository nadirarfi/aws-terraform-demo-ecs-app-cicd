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
| [aws_codebuild_project.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_project) | resource |
| [aws_iam_policy.codebuild_service_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.codebuild_service_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.codebuild_service_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_ssm_parameter.codebuild_project_id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_codebuild_artifact_type"></a> [codebuild\_artifact\_type](#input\_codebuild\_artifact\_type) | n/a | `string` | `"CODEPIPELINE"` | no |
| <a name="input_codebuild_buildspec_file_path"></a> [codebuild\_buildspec\_file\_path](#input\_codebuild\_buildspec\_file\_path) | n/a | `string` | `"buildspec.yml"` | no |
| <a name="input_codebuild_ecr_repository_project_arn"></a> [codebuild\_ecr\_repository\_project\_arn](#input\_codebuild\_ecr\_repository\_project\_arn) | n/a | `string` | `""` | no |
| <a name="input_codebuild_env_compute_type"></a> [codebuild\_env\_compute\_type](#input\_codebuild\_env\_compute\_type) | n/a | `string` | `"BUILD_GENERAL1_SMALL"` | no |
| <a name="input_codebuild_env_image"></a> [codebuild\_env\_image](#input\_codebuild\_env\_image) | n/a | `string` | `"aws/codebuild/amazonlinux2-x86_64-standard:4.0"` | no |
| <a name="input_codebuild_env_type"></a> [codebuild\_env\_type](#input\_codebuild\_env\_type) | n/a | `string` | `"LINUX_CONTAINER"` | no |
| <a name="input_codebuild_env_variables"></a> [codebuild\_env\_variables](#input\_codebuild\_env\_variables) | n/a | <pre>list(<br>    object({<br>      name  = string,<br>      value = string<br>      }<br>    )<br>  )</pre> | `[]` | no |
| <a name="input_codebuild_image_pull_credentials_type"></a> [codebuild\_image\_pull\_credentials\_type](#input\_codebuild\_image\_pull\_credentials\_type) | n/a | `string` | `"CODEBUILD"` | no |
| <a name="input_codebuild_log_group_name"></a> [codebuild\_log\_group\_name](#input\_codebuild\_log\_group\_name) | n/a | `string` | `""` | no |
| <a name="input_codebuild_log_stream_name"></a> [codebuild\_log\_stream\_name](#input\_codebuild\_log\_stream\_name) | n/a | `string` | `""` | no |
| <a name="input_codebuild_project_name"></a> [codebuild\_project\_name](#input\_codebuild\_project\_name) | n/a | `string` | `"codebuild-proejct"` | no |
| <a name="input_codebuild_service_role_name"></a> [codebuild\_service\_role\_name](#input\_codebuild\_service\_role\_name) | n/a | `string` | `"codebuild-project-iam-role"` | no |
| <a name="input_codebuild_source_type"></a> [codebuild\_source\_type](#input\_codebuild\_source\_type) | n/a | `string` | `"CODEPIPELINE"` | no |
| <a name="input_codebuild_timeout"></a> [codebuild\_timeout](#input\_codebuild\_timeout) | 10min timeout | `number` | `10` | no |
| <a name="input_ssm_codebuild_project_id_key"></a> [ssm\_codebuild\_project\_id\_key](#input\_ssm\_codebuild\_project\_id\_key) | n/a | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of additional tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

No outputs.
