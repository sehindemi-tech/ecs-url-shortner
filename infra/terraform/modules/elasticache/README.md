# elasticache

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
| [aws_elasticache_parameter_group.elasticache_paramter_group](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/elasticache_parameter_group) | resource |
| [aws_elasticache_subnet_group.elasticache_subnet_group](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/elasticache_subnet_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_elasticache_family"></a> [elasticache\_family](#input\_elasticache\_family) | The family of the ElastiCache parameter group | `string` | n/a | yes |
| <a name="input_elasticache_parameters"></a> [elasticache\_parameters](#input\_elasticache\_parameters) | The parameters for the ElastiCache parameter group | <pre>map(object({<br/>    value = string<br/>  }))</pre> | n/a | yes |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | The IDs of the private subnets for the ElastiCache subnet group | `list(string)` | n/a | yes |
| <a name="input_project_settings"></a> [project\_settings](#input\_project\_settings) | The Project setting for the url-shortner | <pre>object({<br/>    aws_region                 = string<br/>    github_org                 = string<br/>    project_name               = string<br/>    github_repo                = string<br/>    environment                = string<br/>    github_repository_id       = string<br/>    github_repository_owner_id = string<br/>  })</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
