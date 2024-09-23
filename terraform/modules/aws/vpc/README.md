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
| [aws_eip.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route_table.rt_private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.rt_public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.rt_assoc_priv_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.rt_assoc_pub_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_ssm_parameter.private_subnets_id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.public_subnets_id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.vpc_id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_subnet.private_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | The CIDR block for the VPC. | `string` | n/a | yes |
| <a name="input_enable_internet_gateway"></a> [enable\_internet\_gateway](#input\_enable\_internet\_gateway) | Boolean to create an Internet Gateway | `bool` | `true` | no |
| <a name="input_enable_nat_gateway"></a> [enable\_nat\_gateway](#input\_enable\_nat\_gateway) | Boolean to create a NAT Gateway | `bool` | `true` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | List of private subnets with availability zone and CIDR block. | <pre>list(object({<br>    availability_zone = string<br>    cidr_block        = string<br>  }))</pre> | n/a | yes |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | List of public subnets with availability zone and CIDR block. | <pre>list(object({<br>    availability_zone = string<br>    cidr_block        = string<br>  }))</pre> | n/a | yes |
| <a name="input_ssm_private_subnets_id_key"></a> [ssm\_private\_subnets\_id\_key](#input\_ssm\_private\_subnets\_id\_key) | n/a | `string` | n/a | yes |
| <a name="input_ssm_public_subnets_id_key"></a> [ssm\_public\_subnets\_id\_key](#input\_ssm\_public\_subnets\_id\_key) | n/a | `string` | n/a | yes |
| <a name="input_ssm_vpc_id_key"></a> [ssm\_vpc\_id\_key](#input\_ssm\_vpc\_id\_key) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of additional tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_igw_id"></a> [igw\_id](#output\_igw\_id) | n/a |
| <a name="output_natgw_id"></a> [natgw\_id](#output\_natgw\_id) | n/a |
| <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](#output\_private\_subnet\_ids) | n/a |
| <a name="output_public_subnet_ids"></a> [public\_subnet\_ids](#output\_public\_subnet\_ids) | n/a |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | ========== Outputs ========== |
