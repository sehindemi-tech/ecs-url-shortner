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
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_group.vpc_flow_log](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_metric_alarm.dlq_alarm](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.ecs_running_task_alarms](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.rds_alarm](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_sns_topic.this](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/sns_topic) | resource |
| [aws_sns_topic_subscription.this](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/sns_topic_subscription) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alert_email"></a> [alert\_email](#input\_alert\_email) | Email address to receive CloudWatch alarm notifications | `string` | n/a | yes |
| <a name="input_cloudwatch_log_groups"></a> [cloudwatch\_log\_groups](#input\_cloudwatch\_log\_groups) | The cloudwatch log groups | <pre>map(object({<br/>    name                        = string<br/>    retention_in_days           = number<br/>    deletion_protection_enabled = bool<br/>    log_group_class             = string<br/>  }))</pre> | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | ECS cluster name, as used in the ClusterName metric dimension. | `string` | n/a | yes |
| <a name="input_db_instance_identifier"></a> [db\_instance\_identifier](#input\_db\_instance\_identifier) | The identifier of the RDS DB instance | `string` | n/a | yes |
| <a name="input_dlq_alarm"></a> [dlq\_alarm](#input\_dlq\_alarm) | Configuration for the DLQ CloudWatch alarm | <pre>object({<br/>    comparison_operator = string<br/>    evaluation_periods  = number<br/>    metric_name         = string<br/>    namespace           = string<br/>    period              = number<br/>    statistic           = string<br/>    threshold           = number<br/>    actions_enabled     = bool<br/>    datapoints_to_alarm = number<br/>    treat_missing_data  = string<br/>  })</pre> | n/a | yes |
| <a name="input_dlq_name"></a> [dlq\_name](#input\_dlq\_name) | The name of the Dlq | `string` | n/a | yes |
| <a name="input_ecs_running_task_alarms"></a> [ecs\_running\_task\_alarms](#input\_ecs\_running\_task\_alarms) | Configuration for ECS running task CloudWatch alarms | <pre>map(object({<br/>    comparison_operator = string<br/>    evaluation_periods  = number<br/>    metric_name         = string<br/>    namespace           = string<br/>    period              = number<br/>    statistic           = string<br/>    threshold           = number<br/>    actions_enabled     = bool<br/>    datapoints_to_alarm = number<br/>    treat_missing_data  = string<br/>  }))</pre> | n/a | yes |
| <a name="input_ecs_service_names"></a> [ecs\_service\_names](#input\_ecs\_service\_names) | ECS service names keyed like ecs\_running\_task\_alarms. | `string` | n/a | yes |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | The ARN of the KMS key to use for encrypting CloudWatch log groups | `string` | n/a | yes |
| <a name="input_project_settings"></a> [project\_settings](#input\_project\_settings) | The Project setting for the url-shortner | <pre>object({<br/>    aws_region                 = string<br/>    github_org                 = string<br/>    project_name               = string<br/>    github_repo                = string<br/>    environment                = string<br/>    github_repository_id       = string<br/>    github_repository_owner_id = string<br/>  })</pre> | n/a | yes |
| <a name="input_rds_alarm"></a> [rds\_alarm](#input\_rds\_alarm) | Configuration for the RDS CloudWatch alarm | <pre>object({<br/>    comparison_operator = string<br/>    evaluation_periods  = number<br/>    metric_name         = string<br/>    namespace           = string<br/>    period              = number<br/>    statistic           = string<br/>    threshold           = number<br/>    actions_enabled     = bool<br/>    datapoints_to_alarm = number<br/>    treat_missing_data  = string<br/>  })</pre> | n/a | yes |
| <a name="input_vpc_flow_logs_cloudwatch_log_group"></a> [vpc\_flow\_logs\_cloudwatch\_log\_group](#input\_vpc\_flow\_logs\_cloudwatch\_log\_group) | Settings for the CloudWatch log group used by VPC flow logs | <pre>object({<br/>    name                        = string<br/>    retention_in_days           = number<br/>    deletion_protection_enabled = bool<br/>    log_group_class             = string<br/>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vpc_flow_log_cloudwatch_log_group_name"></a> [vpc\_flow\_log\_cloudwatch\_log\_group\_name](#output\_vpc\_flow\_log\_cloudwatch\_log\_group\_name) | The name of the CloudWatch log group for VPC flow logs |
<!-- END_TF_DOCS -->
