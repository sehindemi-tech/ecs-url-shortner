# alb

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
| [aws_lb.this](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/lb) | resource |
| [aws_lb_listener.http](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/lb_listener) | resource |
| [aws_lb_listener.https](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/lb_listener) | resource |
| [aws_lb_listener.test](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/lb_listener) | resource |
| [aws_lb_listener_rule.prod](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/lb_listener_rule) | resource |
| [aws_lb_listener_rule.test](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/lb_listener_rule) | resource |
| [aws_lb_target_group.this](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/lb_target_group) | resource |
| [aws_s3_bucket.access_logs](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_lifecycle_configuration.access_logs](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_policy.access_logs](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.access_logs](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.access_logs](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.access_logs](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acm_arn"></a> [acm\_arn](#input\_acm\_arn) | ARN of the ACM certificate for the HTTPS listener | `string` | n/a | yes |
| <a name="input_alb_security_groups"></a> [alb\_security\_groups](#input\_alb\_security\_groups) | Security groups for the ALB | `list(string)` | n/a | yes |
| <a name="input_alb_settings"></a> [alb\_settings](#input\_alb\_settings) | Settings for the ALB | <pre>object({<br/>    internal                         = bool<br/>    ip_address_type                  = string<br/>    load_balancer_type               = string<br/>    drop_invalid_header_fields       = bool<br/>    enable_cross_zone_load_balancing = bool<br/>    enable_deletion_protection       = bool<br/>    enable_http2                     = bool<br/>    enable_zonal_shift               = bool<br/>    idle_timeout_seconds             = number<br/>    health_check_log_enabled         = bool<br/>    access_logs_enabled              = bool<br/>    connection_logs_enabled          = bool<br/>  })</pre> | n/a | yes |
| <a name="input_health_check"></a> [health\_check](#input\_health\_check) | Health check settings for the target groups | <pre>object({<br/>    healthy_threshold   = number<br/>    unhealthy_threshold = number<br/>    interval            = number<br/>    timeout             = number<br/>    path                = string<br/>    matcher             = string<br/>    port                = string<br/>    protocol            = string<br/>  })</pre> | n/a | yes |
| <a name="input_http_listener"></a> [http\_listener](#input\_http\_listener) | HTTP listener for the ALB | <pre>object({<br/>    port                = number<br/>    protocol            = string<br/>    default_action_type = string<br/>    redirect = object({<br/>      protocol    = string<br/>      port        = number<br/>      status_code = string<br/>    })<br/>  })</pre> | n/a | yes |
| <a name="input_https_listener"></a> [https\_listener](#input\_https\_listener) | HTTPS listener for the ALB | <pre>object({<br/>    port                = number<br/>    protocol            = string<br/>    ssl_policy          = string<br/>    default_action_type = string<br/>  })</pre> | n/a | yes |
| <a name="input_listener_rules"></a> [listener\_rules](#input\_listener\_rules) | Map of listener rules | <pre>map(object({<br/>    priority           = number<br/>    blue_target_group  = string<br/>    green_target_group = string<br/>    host               = string<br/>  }))</pre> | n/a | yes |
| <a name="input_project_settings"></a> [project\_settings](#input\_project\_settings) | The Project setting for the url-shortner | <pre>object({<br/>    aws_region                 = string<br/>    github_org                 = string<br/>    project_name               = string<br/>    github_repo                = string<br/>    environment                = string<br/>    github_repository_id       = string<br/>    github_repository_owner_id = string<br/>  })</pre> | n/a | yes |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | Subnets for the ALB | `list(string)` | n/a | yes |
| <a name="input_s3_access_logs_setting"></a> [s3\_access\_logs\_setting](#input\_s3\_access\_logs\_setting) | Settings for the S3 access logs bucket | <pre>object({<br/>    s3_bucket = object({<br/>      force_destroy = bool<br/>    })<br/>    sse_encrytption = object({<br/>      sse_algorithm = string<br/>    })<br/>    lifecycle = object({<br/>      id                                     = string<br/>      status                                 = string<br/>      noncurrent_days                        = number<br/>      newer_noncurrent_versions              = number<br/>      abort_incomplete_multipart_upload_days = number<br/>      expiration_days                        = number<br/>      transition_default_minimum_object_size = string<br/>    })<br/>  })</pre> | n/a | yes |
| <a name="input_target_group_name_prefix"></a> [target\_group\_name\_prefix](#input\_target\_group\_name\_prefix) | Prefix for the target group names | `string` | n/a | yes |
| <a name="input_target_groups"></a> [target\_groups](#input\_target\_groups) | Target groups for the ALB | <pre>map(object({<br/>    port                              = number<br/>    protocol                          = string<br/>    target_type                       = string<br/>    ip_address_type                   = string<br/>    deregistration_delay              = number<br/>    load_balancing_algorithm_type     = string<br/>    load_balancing_cross_zone_enabled = bool<br/>  }))</pre> | n/a | yes |
| <a name="input_test_listener"></a> [test\_listener](#input\_test\_listener) | Test listener rule | <pre>object({<br/>    port                = number<br/>    protocol            = string<br/>    ssl_policy          = string<br/>    default_action_type = string<br/>  })</pre> | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_arn"></a> [alb\_arn](#output\_alb\_arn) | ARN of the load balancer, for WAF association. |
| <a name="output_alb_arn_suffix"></a> [alb\_arn\_suffix](#output\_alb\_arn\_suffix) | ARN suffix, the dimension value for CloudWatch ALB metrics. |
| <a name="output_alb_dns_name"></a> [alb\_dns\_name](#output\_alb\_dns\_name) | DNS name of the load balancer, the Route 53 alias target. |
| <a name="output_alb_zone_id"></a> [alb\_zone\_id](#output\_alb\_zone\_id) | Hosted zone ID of the load balancer, for the Route 53 alias record. |
<!-- END_TF_DOCS -->
