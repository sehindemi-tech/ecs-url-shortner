resource "aws_db_parameter_group" "this" {
  name_prefix = "${var.project_settings.project_name}-${var.project_settings.environment}-db-parameter-group-"
  description = "The RDS DB parameter group for the ${var.project_settings.project_name} project"
  family      = var.db_parameter_group_family

  dynamic "parameter" {
    for_each = var.db_parameters
    content {
      name         = parameter.key
      value        = parameter.value.value
      apply_method = parameter.value.apply_method
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}
