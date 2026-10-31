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
| <a name="input_project_settings"></a> [project\_settings](#input\_project\_settings) | The Project setting for the url-shortner | <pre>object({<br/>    aws_region                 = string<br/>    github_org                 = string<br/>    project_name               = string<br/>    github_repo                = string<br/>    environment                = string<br/>    github_repository_id       = string<br/>    github_repository_owner_id = string<br/>  })</pre> | n/a | yes |
| <a name="input_s3_access_logs_setting"></a> [s3\_access\_logs\_setting](#input\_s3\_access\_logs\_setting) | Settings for the S3 access logs bucket | <pre>object({<br/>    s3_bucket = object({<br/>      force_destroy = bool<br/>    })<br/>    sse_encrytption = object({<br/>      sse_algorithm = string<br/>    })<br/>    lifecycle = object({<br/>      id                                     = string<br/>      status                                 = string<br/>      noncurrent_days                        = number<br/>      newer_noncurrent_versions              = number<br/>      abort_incomplete_multipart_upload_days = number<br/>      expiration_days                        = number<br/>      transition_default_minimum_object_size = string<br/>    })<br/>  })</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
