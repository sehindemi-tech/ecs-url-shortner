<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.15.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 6.62.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_monitoring"></a> [monitoring](#module\_monitoring) | ../../modules/monitoring | n/a |
| <a name="module_networking"></a> [networking](#module\_networking) | ../../modules/networking | n/a |
| <a name="module_security"></a> [security](#module\_security) | ../../modules/security | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_ingress_rules"></a> [alb\_ingress\_rules](#input\_alb\_ingress\_rules) | The ingress rules for the ALB security group, keyed by rule name. | <pre>map(object({<br/>    cidr_ipv4   = string<br/>    description = string<br/>    from_port   = number<br/>    to_port     = number<br/>    ip_protocol = string<br/>  }))</pre> | n/a | yes |
| <a name="input_alert_email"></a> [alert\_email](#input\_alert\_email) | Email address to receive CloudWatch alarm notifications | `string` | n/a | yes |
| <a name="input_cloudwatch_log_groups"></a> [cloudwatch\_log\_groups](#input\_cloudwatch\_log\_groups) | The cloudwatch log groups | <pre>map(object({<br/>    name                        = string<br/>    retention_in_days           = number<br/>    deletion_protection_enabled = bool<br/>    log_group_class             = string<br/>  }))</pre> | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | ECS cluster name, as used in the ClusterName metric dimension. | `string` | n/a | yes |
| <a name="input_db_instance_identifier"></a> [db\_instance\_identifier](#input\_db\_instance\_identifier) | The identifier of the RDS DB instance | `string` | n/a | yes |
| <a name="input_dlq_alarm"></a> [dlq\_alarm](#input\_dlq\_alarm) | Configuration for the DLQ CloudWatch alarm | <pre>object({<br/>    comparison_operator = string<br/>    evaluation_periods  = number<br/>    metric_name         = string<br/>    namespace           = string<br/>    period              = number<br/>    statistic           = string<br/>    threshold           = number<br/>    actions_enabled     = bool<br/>    datapoints_to_alarm = number<br/>    treat_missing_data  = string<br/>  })</pre> | n/a | yes |
| <a name="input_dlq_name"></a> [dlq\_name](#input\_dlq\_name) | The name of the Dlq | `string` | n/a | yes |
| <a name="input_ecs_running_task_alarms"></a> [ecs\_running\_task\_alarms](#input\_ecs\_running\_task\_alarms) | Configuration for ECS running task CloudWatch alarms | <pre>map(object({<br/>    comparison_operator = string<br/>    evaluation_periods  = number<br/>    metric_name         = string<br/>    namespace           = string<br/>    period              = number<br/>    statistic           = string<br/>    threshold           = number<br/>    actions_enabled     = bool<br/>    datapoints_to_alarm = number<br/>    treat_missing_data  = string<br/>  }))</pre> | n/a | yes |
| <a name="input_ecs_service_names"></a> [ecs\_service\_names](#input\_ecs\_service\_names) | ECS service names keyed like ecs\_running\_task\_alarms. | `string` | n/a | yes |
| <a name="input_interface_endpoints"></a> [interface\_endpoints](#input\_interface\_endpoints) | A map of VPC endpoints to create | `list(string)` | n/a | yes |
| <a name="input_kms_keys"></a> [kms\_keys](#input\_kms\_keys) | A map of KMS keys to create | <pre>map(object({<br/>    description             = string<br/>    deletion_window_in_days = number<br/>    enable_key_rotation     = bool<br/>    is_enabled              = bool<br/>    actions                 = optional(list(string))<br/>    allow_cloudwatch_logs   = optional(bool, false)<br/>    allow_cloudwatch_alarms = optional(bool, false)<br/>  }))</pre> | n/a | yes |
| <a name="input_project_settings"></a> [project\_settings](#input\_project\_settings) | The Project setting for the url-shortner | <pre>object({<br/>    aws_region                 = string<br/>    github_org                 = string<br/>    project_name               = string<br/>    github_repo                = string<br/>    environment                = string<br/>    github_repository_id       = string<br/>    github_repository_owner_id = string<br/>  })</pre> | n/a | yes |
| <a name="input_rds_alarm"></a> [rds\_alarm](#input\_rds\_alarm) | Configuration for the RDS CloudWatch alarm | <pre>object({<br/>    comparison_operator = string<br/>    evaluation_periods  = number<br/>    metric_name         = string<br/>    namespace           = string<br/>    period              = number<br/>    statistic           = string<br/>    threshold           = number<br/>    actions_enabled     = bool<br/>    datapoints_to_alarm = number<br/>    treat_missing_data  = string<br/>  })</pre> | n/a | yes |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | The security groups for the ecs-shortner project | <pre>map(object({<br/>    description = string<br/>    s3_egress   = optional(bool, false)<br/>  }))</pre> | n/a | yes |
| <a name="input_sg_flows"></a> [sg\_flows](#input\_sg\_flows) | TCP flows between security groups, keyed by flow name. | <pre>map(object({<br/>    from = string<br/>    to   = string<br/>    port = number<br/>  }))</pre> | n/a | yes |
| <a name="input_subnet_settings"></a> [subnet\_settings](#input\_subnet\_settings) | Subnet settings for the ecs-url-shortner | <pre>map(object({<br/>    availability_zone       = string<br/>    cidr_block              = string<br/>    map_public_ip_on_launch = bool<br/>    is_public               = bool<br/>  }))</pre> | n/a | yes |
| <a name="input_vpc_flow_log_settings"></a> [vpc\_flow\_log\_settings](#input\_vpc\_flow\_log\_settings) | VPC flow log settings | <pre>object({<br/>    log_destination_type = string<br/>    traffic_type         = string<br/>  })</pre> | n/a | yes |
| <a name="input_vpc_flow_logs_cloudwatch_log_group"></a> [vpc\_flow\_logs\_cloudwatch\_log\_group](#input\_vpc\_flow\_logs\_cloudwatch\_log\_group) | Settings for the CloudWatch log group used by VPC flow logs | <pre>object({<br/>    name                        = string<br/>    retention_in_days           = number<br/>    deletion_protection_enabled = bool<br/>    log_group_class             = string<br/>  })</pre> | n/a | yes |
| <a name="input_vpc_settings"></a> [vpc\_settings](#input\_vpc\_settings) | Settings for the url\_shortner VPC | <pre>object({<br/>    cidr_block           = string<br/>    enable_dns_support   = bool<br/>    enable_dns_hostnames = bool<br/>  })</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
