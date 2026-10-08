# monitoring

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
| [aws_cloudwatch_log_group.vpc_flow_log](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/cloudwatch_log_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_project_settings"></a> [project\_settings](#input\_project\_settings) | The Project setting for the url-shortner | <pre>object({<br/>    aws_region                 = string<br/>    github_org                 = string<br/>    project_name               = string<br/>    github_repo                = string<br/>    environment                = string<br/>    github_repository_id       = string<br/>    github_repository_owner_id = string<br/>  })</pre> | n/a | yes |
| <a name="input_vpc_flow_logs_cloudwatch_log_group"></a> [vpc\_flow\_logs\_cloudwatch\_log\_group](#input\_vpc\_flow\_logs\_cloudwatch\_log\_group) | Settings for the CloudWatch log group used by VPC flow logs | <pre>object({<br/>    name                        = string<br/>    retention_in_days           = number<br/>    deletion_protection_enabled = bool<br/>    log_group_class             = string<br/>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vpc_flow_log_cloudwatch_log_group_name"></a> [vpc\_flow\_log\_cloudwatch\_log\_group\_name](#output\_vpc\_flow\_log\_cloudwatch\_log\_group\_name) | The name of the CloudWatch log group for VPC flow logs |
<!-- END_TF_DOCS -->
