# security

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
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/security_group) | resource |
| [aws_vpc_security_group_egress_rule.flow](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_egress_rule.tasks_to_s3](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.flow](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.internet_to_alb](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/vpc_security_group_ingress_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_ingress_rules"></a> [alb\_ingress\_rules](#input\_alb\_ingress\_rules) | The ingress rules for the ALB security group, keyed by rule name. | <pre>map(object({<br/>    cidr_ipv4   = string<br/>    description = string<br/>    from_port   = number<br/>    to_port     = number<br/>    ip_protocol = string<br/>  }))</pre> | n/a | yes |
| <a name="input_project_settings"></a> [project\_settings](#input\_project\_settings) | The Project setting for the url-shortner | <pre>object({<br/>    aws_region                 = string<br/>    github_org                 = string<br/>    project_name               = string<br/>    github_repo                = string<br/>    environment                = string<br/>    github_repository_id       = string<br/>    github_repository_owner_id = string<br/>  })</pre> | n/a | yes |
| <a name="input_s3_prefix_list_id"></a> [s3\_prefix\_list\_id](#input\_s3\_prefix\_list\_id) | The prefix list ID for the S3 gateway endpoint. | `string` | n/a | yes |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | The security groups for the ecs-shortner project | <pre>map(object({<br/>    description = string<br/>    s3_egress   = optional(bool, false)<br/>  }))</pre> | n/a | yes |
| <a name="input_sg_flows"></a> [sg\_flows](#input\_sg\_flows) | TCP flows between security groups, keyed by flow name. | <pre>map(object({<br/>    from = string<br/>    to   = string<br/>    port = number<br/>  }))</pre> | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vpc_endpoint_security_group_id"></a> [vpc\_endpoint\_security\_group\_id](#output\_vpc\_endpoint\_security\_group\_id) | The security group ID associated with interface VPC endpoints |
<!-- END_TF_DOCS -->
