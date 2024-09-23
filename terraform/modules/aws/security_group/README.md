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
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_ssm_parameter.id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | A description of the purpose | `string` | n/a | yes |
| <a name="input_egress_rules"></a> [egress\_rules](#input\_egress\_rules) | List of egress rules | <pre>list(object({<br>    from_port   = number<br>    to_port     = number<br>    protocol    = string<br>    cidr_blocks = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_ingress_rules"></a> [ingress\_rules](#input\_ingress\_rules) | List of ingress rules | <pre>list(object({<br>    from_port       = number<br>    to_port         = number<br>    protocol        = string<br>    cidr_blocks     = list(string)<br>    security_groups = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of your security group | `string` | n/a | yes |
| <a name="input_ssm_security_group_id_key"></a> [ssm\_security\_group\_id\_key](#input\_ssm\_security\_group\_id\_key) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of additional tags to add to all resources. | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC where the security group will take place | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | n/a |
