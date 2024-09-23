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
| [aws_ecs_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |
| [aws_ssm_parameter.ecs_cluster_arn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.ecs_cluster_id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ecs_cluster_name"></a> [ecs\_cluster\_name](#input\_ecs\_cluster\_name) | Name of ECS Cluster. | `string` | `""` | no |
| <a name="input_ssm_ecs_cluster_arn_key"></a> [ssm\_ecs\_cluster\_arn\_key](#input\_ssm\_ecs\_cluster\_arn\_key) | n/a | `string` | `""` | no |
| <a name="input_ssm_ecs_cluster_id_key"></a> [ssm\_ecs\_cluster\_id\_key](#input\_ssm\_ecs\_cluster\_id\_key) | n/a | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of additional tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

No outputs.
