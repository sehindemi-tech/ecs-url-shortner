resource "aws_ssm_parameter" "this" {
  for_each = var.ssm_parameters

  name        = "/${var.project_settings.project_name}/${each.value.name}"
  description = each.value.description
  type        = each.value.type
  value       = each.value.value
}

variable "ssm_parameters" {
  description = "SSM parameters for the Image tags"
  type = map(object({
    description = string
    name        = string
    type        = string
    value       = string
  }))
}
