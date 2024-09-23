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
| [aws_alb.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb) | resource |
| [aws_alb_listener.http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_listener) | resource |
| [aws_alb_listener.https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_listener) | resource |
| [aws_route53_record.alb_alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_idle_timeout"></a> [alb\_idle\_timeout](#input\_alb\_idle\_timeout) | n/a | `number` | `30` | no |
| <a name="input_alb_name"></a> [alb\_name](#input\_alb\_name) | A name for the target group or ALB | `string` | n/a | yes |
| <a name="input_alb_security_groups_id"></a> [alb\_security\_groups\_id](#input\_alb\_security\_groups\_id) | Security group ID for the ALB | `list(string)` | `[]` | no |
| <a name="input_alb_subnets_id"></a> [alb\_subnets\_id](#input\_alb\_subnets\_id) | Subnets IDs for ALB | `list(any)` | `[]` | no |
| <a name="input_alb_target_group_arn"></a> [alb\_target\_group\_arn](#input\_alb\_target\_group\_arn) | Set to true to create a HTTPS listener | `string` | `""` | no |
| <a name="input_create_dns_record"></a> [create\_dns\_record](#input\_create\_dns\_record) | Whether to create a DNS Alias record for the ALB | `bool` | `false` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The domain name for the DNS record | `string` | `""` | no |
| <a name="input_enable_https"></a> [enable\_https](#input\_enable\_https) | Set to true to create a HTTPS listener | `bool` | `false` | no |
| <a name="input_route53_dns_zone_name"></a> [route53\_dns\_zone\_name](#input\_route53\_dns\_zone\_name) | The name of the Route 53 hosted zone (e.g., 'nadirarfi.com') | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of additional tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

No outputs.
