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
| [aws_ecs_service.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.ecs_task_def](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ecs_task_definition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | The name of the container where the load balancer will direct traffic. | `string` | `""` | no |
| <a name="input_container_port"></a> [container\_port](#input\_container\_port) | The port number on the container where the load balancer will direct traffic. | `number` | `80` | no |
| <a name="input_ecs_cluster_id"></a> [ecs\_cluster\_id](#input\_ecs\_cluster\_id) | The ID of the ECS cluster where the service will be deployed. | `string` | `""` | no |
| <a name="input_ecs_health_check_grace_period_seconds"></a> [ecs\_health\_check\_grace\_period\_seconds](#input\_ecs\_health\_check\_grace\_period\_seconds) | The period in seconds for the health check grace period. | `number` | `15` | no |
| <a name="input_ecs_service_deployment_controller_type"></a> [ecs\_service\_deployment\_controller\_type](#input\_ecs\_service\_deployment\_controller\_type) | The type of deployment controller (e.g., ECS, CODE\_DEPLOY, EXTERNAL). | `string` | `"CODE_DEPLOY"` | no |
| <a name="input_ecs_service_desired_count"></a> [ecs\_service\_desired\_count](#input\_ecs\_service\_desired\_count) | The desired number of tasks to run in the service. | `number` | `1` | no |
| <a name="input_ecs_service_launch_type"></a> [ecs\_service\_launch\_type](#input\_ecs\_service\_launch\_type) | The launch type for the ECS service (e.g., EC2, FARGATE). | `string` | `"FARGATE"` | no |
| <a name="input_ecs_service_name"></a> [ecs\_service\_name](#input\_ecs\_service\_name) | The name of the ECS service. | `string` | `"ecs-service"` | no |
| <a name="input_ecs_service_security_groups_id"></a> [ecs\_service\_security\_groups\_id](#input\_ecs\_service\_security\_groups\_id) | The security group IDs for the ECS service. | `list(string)` | `[]` | no |
| <a name="input_ecs_service_subnets_id"></a> [ecs\_service\_subnets\_id](#input\_ecs\_service\_subnets\_id) | The subnet IDs for the ECS service. | `list(string)` | `[]` | no |
| <a name="input_ecs_task_definition_name"></a> [ecs\_task\_definition\_name](#input\_ecs\_task\_definition\_name) | The name of the ECS task definition to use for the service. | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of additional tags to add to all resources. | `map(string)` | `{}` | no |
| <a name="input_target_group_arn"></a> [target\_group\_arn](#input\_target\_group\_arn) | The ARN of the target group to attach to the ECS service. | `string` | `""` | no |

## Outputs

No outputs.
