# rds

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.15.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 6.62.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.9.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.62.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.9.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_db_instance.this](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/db_instance) | resource |
| [aws_db_parameter_group.this](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/db_parameter_group) | resource |
| [aws_db_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/db_subnet_group) | resource |
| [aws_secretsmanager_secret.rds_secrets](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.rds_secrets](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/secretsmanager_secret_version) | resource |
| [random_password.db_pass](https://registry.terraform.io/providers/hashicorp/random/3.9.1/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_db_instance"></a> [db\_instance](#input\_db\_instance) | The configuration for the RDS DB instance | <pre>object({<br/>    skip_final_snapshot             = bool<br/>    allocated_storage               = number<br/>    allow_major_version_upgrade     = bool<br/>    apply_immediately               = bool<br/>    auto_minor_version_upgrade      = bool<br/>    backup_retention_period         = number<br/>    database_insights_mode          = string<br/>    db_name                         = string<br/>    deletion_protection             = bool<br/>    enabled_cloudwatch_logs_exports = list(string)<br/>    engine                          = string<br/>    engine_version                  = string<br/>    identifier                      = string<br/>    instance_class                  = string<br/>    maintenance_window              = string<br/>    max_allocated_storage           = number<br/>    # multi_az = bool<br/>    network_type        = string<br/>    port                = number<br/>    publicly_accessible = bool<br/>    storage_encrypted   = bool<br/>    storage_type        = string<br/>    username            = string<br/>  })</pre> | n/a | yes |
| <a name="input_db_parameter_group_family"></a> [db\_parameter\_group\_family](#input\_db\_parameter\_group\_family) | The RDS DB parameter group family | `string` | n/a | yes |
| <a name="input_db_parameters"></a> [db\_parameters](#input\_db\_parameters) | PostgreSQL parameters  for the RDS DB parameter group | <pre>map(object({<br/>    value        = string<br/>    apply_method = string<br/>  }))</pre> | n/a | yes |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | The IDs of the private subnets for the RDS DB subnet group | `list(string)` | n/a | yes |
| <a name="input_project_settings"></a> [project\_settings](#input\_project\_settings) | The Project setting for the url-shortner | <pre>object({<br/>    aws_region                 = string<br/>    github_org                 = string<br/>    project_name               = string<br/>    github_repo                = string<br/>    environment                = string<br/>    github_repository_id       = string<br/>    github_repository_owner_id = string<br/>  })</pre> | n/a | yes |
| <a name="input_rds_kms_arn"></a> [rds\_kms\_arn](#input\_rds\_kms\_arn) | The KMS key ID for the RDS instance | `string` | n/a | yes |
| <a name="input_rds_security_group_ids"></a> [rds\_security\_group\_ids](#input\_rds\_security\_group\_ids) | List of security group IDs to associate with the RDS instance | `list(string)` | n/a | yes |
| <a name="input_secrets_manager_kms_arn"></a> [secrets\_manager\_kms\_arn](#input\_secrets\_manager\_kms\_arn) | The KMS key ARN for the Secrets Manager secret | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
