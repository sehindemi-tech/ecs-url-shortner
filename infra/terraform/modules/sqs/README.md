# sqs

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
| [aws_sqs_queue.dlq_sqs](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue.main_sqs](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue_redrive_allow_policy.main_sqs_redrive_policy](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/sqs_queue_redrive_allow_policy) | resource |
| [aws_sqs_queue_redrive_policy.main_sqs_redrive_policy](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/sqs_queue_redrive_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dlq_settings"></a> [dlq\_settings](#input\_dlq\_settings) | The Dead Letter Queue settings for the SQS | <pre>object({<br/>    fifo_queue                = bool<br/>    message_retention_seconds = number<br/>  })</pre> | n/a | yes |
| <a name="input_main_sqs_queue"></a> [main\_sqs\_queue](#input\_main\_sqs\_queue) | The main SQS queue settings | <pre>object({<br/>    fifo_queue                 = bool<br/>    message_retention_seconds  = number<br/>    visibility_timeout_seconds = number<br/>  })</pre> | n/a | yes |
| <a name="input_project_settings"></a> [project\_settings](#input\_project\_settings) | The Project setting for the url-shortner | <pre>object({<br/>    aws_region                 = string<br/>    github_org                 = string<br/>    project_name               = string<br/>    github_repo                = string<br/>    environment                = string<br/>    github_repository_id       = string<br/>    github_repository_owner_id = string<br/>  })</pre> | n/a | yes |
| <a name="input_sqs_kms_key_id"></a> [sqs\_kms\_key\_id](#input\_sqs\_kms\_key\_id) | The KMS key ID for the SQS queue | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
