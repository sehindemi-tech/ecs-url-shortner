# networking

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.15.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 6.62.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.62.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.ngw](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/eip) | resource |
| [aws_flow_log.vpc_flow_log](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/flow_log) | resource |
| [aws_iam_role.vpc_flow_log_role](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.vpc_flow_log_role_policy](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/iam_role_policy) | resource |
| [aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.ngw](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/nat_gateway) | resource |
| [aws_route_table.private](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/route_table) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/route_table) | resource |
| [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/route_table_association) | resource |
| [aws_subnet.private_subnets](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/subnet) | resource |
| [aws_subnet.public_subnets](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/subnet) | resource |
| [aws_vpc.url_shortner](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/vpc) | resource |
| [aws_vpc_endpoint.gateway](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.interface](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/vpc_endpoint) | resource |
| [aws_iam_policy_document.vpc_flow_log_role_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.vpc_flow_log_role_policy](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_interface_endpoints"></a> [interface\_endpoints](#input\_interface\_endpoints) | A map of VPC endpoints to create | `list(string)` | n/a | yes |
| <a name="input_project_settings"></a> [project\_settings](#input\_project\_settings) | The Project setting for the url-shortner | <pre>object({<br/>    aws_region                 = string<br/>    github_org                 = string<br/>    project_name               = string<br/>    github_repo                = string<br/>    environment                = string<br/>    github_repository_id       = string<br/>    github_repository_owner_id = string<br/>  })</pre> | n/a | yes |
| <a name="input_subnet_settings"></a> [subnet\_settings](#input\_subnet\_settings) | Subnet settings for the ecs-url-shortner | <pre>map(object({<br/>    availability_zone       = string<br/>    cidr_block              = string<br/>    map_public_ip_on_launch = bool<br/>    is_public               = bool<br/>  }))</pre> | n/a | yes |
| <a name="input_vpc_endpoint_security_group_id"></a> [vpc\_endpoint\_security\_group\_id](#input\_vpc\_endpoint\_security\_group\_id) | The security group ID to associate with interface VPC endpoints | `string` | n/a | yes |
| <a name="input_vpc_flow_log_settings"></a> [vpc\_flow\_log\_settings](#input\_vpc\_flow\_log\_settings) | VPC flow log settings | <pre>object({<br/>    log_destination      = string<br/>    log_destination_type = string<br/>    traffic_type         = string<br/>  })</pre> | n/a | yes |
| <a name="input_vpc_settings"></a> [vpc\_settings](#input\_vpc\_settings) | Settings for the url\_shortner VPC | <pre>object({<br/>    cidr_block           = string<br/>    enable_dns_support   = bool<br/>    enable_dns_hostnames = bool<br/>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_s3_gateway_vpc_endpoint_id"></a> [s3\_gateway\_vpc\_endpoint\_id](#output\_s3\_gateway\_vpc\_endpoint\_id) | The ID of the S3 gateway VPC endpoint |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
<!-- END_TF_DOCS -->
