# elasticache

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
| [aws_elasticache_parameter_group.elasticache_parameter_group](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/elasticache_parameter_group) | resource |
| [aws_elasticache_replication_group.aws_elasticache_replication_group](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/elasticache_replication_group) | resource |
| [aws_elasticache_subnet_group.elasticache_subnet_group](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/elasticache_subnet_group) | resource |
| [random_password.auth](https://registry.terraform.io/providers/hashicorp/random/3.9.1/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_elastic_cache_kms_arn"></a> [elastic\_cache\_kms\_arn](#input\_elastic\_cache\_kms\_arn) | The KMS key ARN for encrypting ElastiCache at rest | `string` | n/a | yes |
| <a name="input_elasticache_family"></a> [elasticache\_family](#input\_elasticache\_family) | The family of the ElastiCache parameter group | `string` | n/a | yes |
| <a name="input_elasticache_parameters"></a> [elasticache\_parameters](#input\_elasticache\_parameters) | The parameters for the ElastiCache parameter group | <pre>map(object({<br/>    value = string<br/>  }))</pre> | n/a | yes |
| <a name="input_elasticache_replication_group"></a> [elasticache\_replication\_group](#input\_elasticache\_replication\_group) | The ElastiCache replication group configuration | <pre>object({<br/>    replication_group_description = string<br/>    apply_immediately             = bool<br/>    at_rest_encryption_enabled    = bool<br/>    auth_token_update_strategy    = string<br/>    auto_minor_version_upgrade    = bool<br/>    engine                        = string<br/>    engine_version                = string<br/>    ip_discovery                  = string<br/>    maintenance_window            = string<br/>    multi_az_enabled              = bool<br/>    network_type                  = string<br/>    num_cache_clusters            = number<br/>    node_type                     = string<br/>    port                          = number<br/>    transit_encryption_enabled    = bool<br/>    transit_encryption_mode       = string<br/>    automatic_failover_enabled    = bool<br/>  })</pre> | n/a | yes |
| <a name="input_elasticache_security_group_ids"></a> [elasticache\_security\_group\_ids](#input\_elasticache\_security\_group\_ids) | The security group IDs for the ElastiCache replication group | `list(string)` | n/a | yes |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | The IDs of the private subnets for the ElastiCache subnet group | `list(string)` | n/a | yes |
| <a name="input_project_settings"></a> [project\_settings](#input\_project\_settings) | The Project setting for the url-shortner | <pre>object({<br/>    aws_region                 = string<br/>    github_org                 = string<br/>    project_name               = string<br/>    github_repo                = string<br/>    environment                = string<br/>    github_repository_id       = string<br/>    github_repository_owner_id = string<br/>  })</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
