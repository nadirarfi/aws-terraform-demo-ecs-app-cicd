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
| [aws_codedeploy_app.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codedeploy_app) | resource |
| [aws_codedeploy_deployment_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codedeploy_deployment_group) | resource |
| [aws_iam_policy.codedeploy_service_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.codedeploy_service_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.codedeploy_service_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_codedeploy_app_auto_rollback_enabled"></a> [codedeploy\_app\_auto\_rollback\_enabled](#input\_codedeploy\_app\_auto\_rollback\_enabled) | Enable or disable automatic rollback | `bool` | `true` | no |
| <a name="input_codedeploy_app_auto_rollback_events"></a> [codedeploy\_app\_auto\_rollback\_events](#input\_codedeploy\_app\_auto\_rollback\_events) | Auto rollback events to trigger rollback | `list(string)` | <pre>[<br>  "DEPLOYMENT_FAILURE"<br>]</pre> | no |
| <a name="input_codedeploy_app_compute_platform"></a> [codedeploy\_app\_compute\_platform](#input\_codedeploy\_app\_compute\_platform) | The compute platform for CodeDeploy (e.g., ECS) | `string` | `"ECS"` | no |
| <a name="input_codedeploy_app_deployment_config_name"></a> [codedeploy\_app\_deployment\_config\_name](#input\_codedeploy\_app\_deployment\_config\_name) | Deployment configuration name (e.g., CodeDeployDefault.ECSAllAtOnce) | `string` | `"CodeDeployDefault.ECSAllAtOnce"` | no |
| <a name="input_codedeploy_app_deployment_option"></a> [codedeploy\_app\_deployment\_option](#input\_codedeploy\_app\_deployment\_option) | Deployment option (e.g., WITH\_TRAFFIC\_CONTROL) | `string` | `"WITH_TRAFFIC_CONTROL"` | no |
| <a name="input_codedeploy_app_deployment_ready_timeout_action"></a> [codedeploy\_app\_deployment\_ready\_timeout\_action](#input\_codedeploy\_app\_deployment\_ready\_timeout\_action) | Action to take when the deployment is ready (e.g., CONTINUE\_DEPLOYMENT) | `string` | `"CONTINUE_DEPLOYMENT"` | no |
| <a name="input_codedeploy_app_deployment_type"></a> [codedeploy\_app\_deployment\_type](#input\_codedeploy\_app\_deployment\_type) | Deployment type (e.g., BLUE\_GREEN) | `string` | `"BLUE_GREEN"` | no |
| <a name="input_codedeploy_app_environments"></a> [codedeploy\_app\_environments](#input\_codedeploy\_app\_environments) | A map of environments with their specific details | <pre>map(object({<br>    ecs_cluster_name    = string<br>    ecs_service_name    = string<br>    alb_listener_arn   = string<br>    blue_target_group   = string<br>    green_target_group  = string<br>    sns_topic_arn       = string<br>  }))</pre> | <pre>{<br>  "dev": {<br>    "alb_listener_arn": "arn:aws:elasticloadbalancing:region:account-id:listener/app/dev-load-balancer/xyz",<br>    "blue_target_group": "dev-blue-target-group",<br>    "ecs_cluster_name": "dev-ecs-cluster",<br>    "ecs_service_name": "dev-ecs-service",<br>    "green_target_group": "dev-green-target-group",<br>    "sns_topic_arn": "arn:aws:sns:region:account-id:dev-topic"<br>  },<br>  "prod": {<br>    "alb_listener_arn": "arn:aws:elasticloadbalancing:region:account-id:listener/app/prod-load-balancer/abc",<br>    "blue_target_group": "prod-blue-target-group",<br>    "ecs_cluster_name": "prod-ecs-cluster",<br>    "ecs_service_name": "prod-ecs-service",<br>    "green_target_group": "prod-green-target-group",<br>    "sns_topic_arn": "arn:aws:sns:region:account-id:prod-topic"<br>  }<br>}</pre> | no |
| <a name="input_codedeploy_app_name"></a> [codedeploy\_app\_name](#input\_codedeploy\_app\_name) | The name of the CodeDeploy application and deployment group | `string` | `""` | no |
| <a name="input_codedeploy_app_terminate_action"></a> [codedeploy\_app\_terminate\_action](#input\_codedeploy\_app\_terminate\_action) | Action to take when terminating the blue instances | `string` | `"TERMINATE"` | no |
| <a name="input_codedeploy_app_termination_wait_time"></a> [codedeploy\_app\_termination\_wait\_time](#input\_codedeploy\_app\_termination\_wait\_time) | Time to wait in minutes before terminating blue instances | `number` | `5` | no |

## Outputs

No outputs.
