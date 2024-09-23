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
| [aws_ecr_repository.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_ssm_parameter.ecr_repository_arn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.ecr_repository_url](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ecr_repository_name"></a> [ecr\_repository\_name](#input\_ecr\_repository\_name) | n/a | `string` | `""` | no |
| <a name="input_force_delete"></a> [force\_delete](#input\_force\_delete) | n/a | `bool` | `true` | no |
| <a name="input_ssm_ecr_repository_arn_key"></a> [ssm\_ecr\_repository\_arn\_key](#input\_ssm\_ecr\_repository\_arn\_key) | n/a | `string` | `""` | no |
| <a name="input_ssm_ecr_repository_url_key"></a> [ssm\_ecr\_repository\_url\_key](#input\_ssm\_ecr\_repository\_url\_key) | n/a | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of additional tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

No outputs.
