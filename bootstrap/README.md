# bootstrap

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
| [aws_ecr_lifecycle_policy.ecr_shortner_repos_lifecycle](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_repository.ecs_shortener_repos](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/ecr_repository) | resource |
| [aws_iam_openid_connect_provider.this](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_role.terraform_oidc_roles](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.this](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/iam_role_policy) | resource |
| [aws_kms_alias.bootstrap_s3_kms_alias](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/kms_alias) | resource |
| [aws_kms_key.bootstrap_s3_kms_key](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/kms_key) | resource |
| [aws_s3_bucket.terraform_states](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_public_access_block.terraform_state_public_access_block](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.server_side_kms](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.terraform_states_versioning](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/s3_bucket_versioning) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/data-sources/caller_identity) | data source |
| [aws_ecr_lifecycle_policy_document.ecr_shortener_repos_lifecycle_policy](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/data-sources/ecr_lifecycle_policy_document) | data source |
| [aws_iam_policy_document.role_policies](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.s3_bootstrap_kms_key](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.terraform_oidc_roles_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bootstrap_s3_kms_key"></a> [bootstrap\_s3\_kms\_key](#input\_bootstrap\_s3\_kms\_key) | The KMS key settings for the bootstrap S3 bucket | <pre>object({<br/>    description             = optional(string)<br/>    deletion_window_in_days = optional(number, 7)<br/>    enable_key_rotation     = optional(bool, true)<br/>    alias_name              = string<br/>  })</pre> | n/a | yes |
| <a name="input_cicd_roles"></a> [cicd\_roles](#input\_cicd\_roles) | CICD roles using OIDC | <pre>map(object({<br/>    description = string<br/>    sub_values  = string<br/>  }))</pre> | n/a | yes |
| <a name="input_ecr_repositories"></a> [ecr\_repositories](#input\_ecr\_repositories) | ECR repository settings | <pre>map(object({<br/>    image_tag_mutability = optional(string, "IMMUTABLE")<br/>    force_delete         = optional(bool, false)<br/>    encryption_type      = optional(string, "AES256")<br/>    scan_on_push         = optional(bool, true)<br/>  }))</pre> | n/a | yes |
| <a name="input_project_settings"></a> [project\_settings](#input\_project\_settings) | The Project setting for the url-shortner | <pre>object({<br/>    aws_region                 = string<br/>    github_org                 = string<br/>    project_name               = string<br/>    github_repo                = string<br/>    environment                = string<br/>    github_repository_id       = string<br/>    github_repository_owner_id = string<br/>  })</pre> | n/a | yes |
| <a name="input_s3_bucket_settings"></a> [s3\_bucket\_settings](#input\_s3\_bucket\_settings) | The S3 bucket settings for the project | <pre>map(object({<br/>    name          = string<br/>    force_destroy = optional(bool, false)<br/>    description   = optional(string)<br/>    versioning    = optional(bool, true)<br/>    sse_algorithm = optional(string, "aws:kms")<br/>  }))</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
