# dns

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
| [aws_acm_certificate.this](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate_validation.this](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/acm_certificate_validation) | resource |
| [aws_route53_record.validation](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/route53_record) | resource |
| [aws_route53_zone.this](https://registry.terraform.io/providers/hashicorp/aws/6.62.0/docs/resources/route53_zone) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dashboard_domain_name"></a> [dashboard\_domain\_name](#input\_dashboard\_domain\_name) | The domain name for the dashboard to be included as a subject alternative name in the ACM certificate. | `string` | n/a | yes |
| <a name="input_project_settings"></a> [project\_settings](#input\_project\_settings) | The Project setting for the url-shortner | <pre>object({<br/>    aws_region                 = string<br/>    github_org                 = string<br/>    project_name               = string<br/>    github_repo                = string<br/>    environment                = string<br/>    github_repository_id       = string<br/>    github_repository_owner_id = string<br/>  })</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
