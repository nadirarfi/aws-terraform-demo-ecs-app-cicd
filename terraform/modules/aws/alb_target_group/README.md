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
| [aws_alb_target_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_target_group) | resource |
| [aws_ssm_parameter.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_target_group_deregistration_delay"></a> [alb\_target\_group\_deregistration\_delay](#input\_alb\_target\_group\_deregistration\_delay) | n/a | `number` | `5` | no |
| <a name="input_alb_target_group_health_check_healthy_threshold"></a> [alb\_target\_group\_health\_check\_healthy\_threshold](#input\_alb\_target\_group\_health\_check\_healthy\_threshold) | n/a | `number` | `2` | no |
| <a name="input_alb_target_group_health_check_interval"></a> [alb\_target\_group\_health\_check\_interval](#input\_alb\_target\_group\_health\_check\_interval) | n/a | `number` | `15` | no |
| <a name="input_alb_target_group_health_check_matcher"></a> [alb\_target\_group\_health\_check\_matcher](#input\_alb\_target\_group\_health\_check\_matcher) | n/a | `string` | `"200,301"` | no |
| <a name="input_alb_target_group_health_check_path"></a> [alb\_target\_group\_health\_check\_path](#input\_alb\_target\_group\_health\_check\_path) | The path in which the ALB will send health checks | `string` | `"/health"` | no |
| <a name="input_alb_target_group_health_check_port"></a> [alb\_target\_group\_health\_check\_port](#input\_alb\_target\_group\_health\_check\_port) | The port to which the ALB will send health checks | `number` | `80` | no |
| <a name="input_alb_target_group_health_check_protocol"></a> [alb\_target\_group\_health\_check\_protocol](#input\_alb\_target\_group\_health\_check\_protocol) | The protocol that the target group will use | `string` | `"HTTP"` | no |
| <a name="input_alb_target_group_health_check_timeout"></a> [alb\_target\_group\_health\_check\_timeout](#input\_alb\_target\_group\_health\_check\_timeout) | n/a | `number` | `10` | no |
| <a name="input_alb_target_group_health_check_unhealthy_threshold"></a> [alb\_target\_group\_health\_check\_unhealthy\_threshold](#input\_alb\_target\_group\_health\_check\_unhealthy\_threshold) | n/a | `number` | `3` | no |
| <a name="input_alb_target_group_name"></a> [alb\_target\_group\_name](#input\_alb\_target\_group\_name) | n/a | `string` | `""` | no |
| <a name="input_alb_target_group_port"></a> [alb\_target\_group\_port](#input\_alb\_target\_group\_port) | n/a | `number` | `80` | no |
| <a name="input_alb_target_group_protocol"></a> [alb\_target\_group\_protocol](#input\_alb\_target\_group\_protocol) | n/a | `string` | `"HTTP"` | no |
| <a name="input_alb_target_group_type"></a> [alb\_target\_group\_type](#input\_alb\_target\_group\_type) | Target Group Type (instance, ip, lambda) | `string` | `"ip"` | no |
| <a name="input_ssm_alb_target_group_arn_key"></a> [ssm\_alb\_target\_group\_arn\_key](#input\_ssm\_alb\_target\_group\_arn\_key) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of additional tags to add to all resources. | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID for the Target Group | `string` | `""` | no |

## Outputs

No outputs.
