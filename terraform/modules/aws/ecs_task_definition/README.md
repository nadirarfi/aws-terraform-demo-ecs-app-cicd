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
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_ecs_task_definition.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_policy.ecs_task_execution_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.ecs_task_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.ecs_task_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.ecs_task_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.ecs_task_execution_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecs_task_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_ssm_parameter.ecs_task_definition_arn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.ecs_task_definition_execution_role_arn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.ecs_task_definition_role_arn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_iam_policy_document.ecs_task_execution_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ecs_task_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ecs_task_container_name"></a> [ecs\_task\_container\_name](#input\_ecs\_task\_container\_name) | The name of the container in the task. | `string` | `""` | no |
| <a name="input_ecs_task_container_port"></a> [ecs\_task\_container\_port](#input\_ecs\_task\_container\_port) | The port on which the container listens. | `number` | `80` | no |
| <a name="input_ecs_task_cpu"></a> [ecs\_task\_cpu](#input\_ecs\_task\_cpu) | The number of CPU units used by the task. | `number` | `256` | no |
| <a name="input_ecs_task_ecr_image_repository_url"></a> [ecs\_task\_ecr\_image\_repository\_url](#input\_ecs\_task\_ecr\_image\_repository\_url) | The ECR repository URL for the container image. | `string` | `""` | no |
| <a name="input_ecs_task_ecr_image_tag"></a> [ecs\_task\_ecr\_image\_tag](#input\_ecs\_task\_ecr\_image\_tag) | n/a | `string` | `"latest"` | no |
| <a name="input_ecs_task_environment_variables"></a> [ecs\_task\_environment\_variables](#input\_ecs\_task\_environment\_variables) | List of environment variables for the ECS container. | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | `[]` | no |
| <a name="input_ecs_task_execution_role_name"></a> [ecs\_task\_execution\_role\_name](#input\_ecs\_task\_execution\_role\_name) | The name of the IAM execution role for the ECS task. | `string` | `""` | no |
| <a name="input_ecs_task_execution_role_statements"></a> [ecs\_task\_execution\_role\_statements](#input\_ecs\_task\_execution\_role\_statements) | n/a | `list` | `[]` | no |
| <a name="input_ecs_task_health_check_container_path"></a> [ecs\_task\_health\_check\_container\_path](#input\_ecs\_task\_health\_check\_container\_path) | n/a | `string` | `"/health/status"` | no |
| <a name="input_ecs_task_health_check_container_port"></a> [ecs\_task\_health\_check\_container\_port](#input\_ecs\_task\_health\_check\_container\_port) | n/a | `number` | `80` | no |
| <a name="input_ecs_task_log_group_name"></a> [ecs\_task\_log\_group\_name](#input\_ecs\_task\_log\_group\_name) | The name of the CloudWatch log group. | `string` | `""` | no |
| <a name="input_ecs_task_log_stream_prefix"></a> [ecs\_task\_log\_stream\_prefix](#input\_ecs\_task\_log\_stream\_prefix) | Prefix for the log stream in CloudWatch. | `string` | `""` | no |
| <a name="input_ecs_task_memory"></a> [ecs\_task\_memory](#input\_ecs\_task\_memory) | The amount of memory (in MiB) used by the task. | `number` | `512` | no |
| <a name="input_ecs_task_name"></a> [ecs\_task\_name](#input\_ecs\_task\_name) | The name of the ECS task family. | `string` | `"ecs-task-name"` | no |
| <a name="input_ecs_task_role_name"></a> [ecs\_task\_role\_name](#input\_ecs\_task\_role\_name) | The name of the IAM task role for the ECS task. | `string` | `""` | no |
| <a name="input_ecs_task_role_statements"></a> [ecs\_task\_role\_statements](#input\_ecs\_task\_role\_statements) | n/a | `list` | `[]` | no |
| <a name="input_ssm_ecs_task_definition_arn_key"></a> [ssm\_ecs\_task\_definition\_arn\_key](#input\_ssm\_ecs\_task\_definition\_arn\_key) | n/a | `string` | `""` | no |
| <a name="input_ssm_ecs_task_definition_execution_role_arn_key"></a> [ssm\_ecs\_task\_definition\_execution\_role\_arn\_key](#input\_ssm\_ecs\_task\_definition\_execution\_role\_arn\_key) | n/a | `string` | `""` | no |
| <a name="input_ssm_ecs_task_definition_role_arn_key"></a> [ssm\_ecs\_task\_definition\_role\_arn\_key](#input\_ssm\_ecs\_task\_definition\_role\_arn\_key) | n/a | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to apply to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecs_task_definition_arn"></a> [ecs\_task\_definition\_arn](#output\_ecs\_task\_definition\_arn) | The ARN of the ECS task definition. |
