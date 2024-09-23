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
| [aws_dynamodb_table.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dynamodb_table_attributes"></a> [dynamodb\_table\_attributes](#input\_dynamodb\_table\_attributes) | A map of attributes to be used in the DynamoDB table. Each attribute should have a name and type. | <pre>list(object({<br>    name = string<br>    type = string<br>  }))</pre> | <pre>[<br>  {<br>    "name": "id",<br>    "type": "N"<br>  }<br>]</pre> | no |
| <a name="input_dynamodb_table_hash_key"></a> [dynamodb\_table\_hash\_key](#input\_dynamodb\_table\_hash\_key) | The attribute to use as the hash (partition) key for the table | `string` | n/a | yes |
| <a name="input_dynamodb_table_name"></a> [dynamodb\_table\_name](#input\_dynamodb\_table\_name) | The name of the DynamoDB table | `string` | n/a | yes |
| <a name="input_dynamodb_table_range_key"></a> [dynamodb\_table\_range\_key](#input\_dynamodb\_table\_range\_key) | The attribute to use as the range (sort) key for the table (optional) | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_table_arn"></a> [table\_arn](#output\_table\_arn) | n/a |
| <a name="output_table_name"></a> [table\_name](#output\_table\_name) | n/a |
