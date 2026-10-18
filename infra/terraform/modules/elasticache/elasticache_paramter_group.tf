resource "aws_elasticache_parameter_group" "elasticache_paramter_group" {
  name        = "${var.project_settings.project_name}-cache-parameter-group"
  description = "ElastiCache parameter group for ecs-url-shortner"
  family      = var.elasticache_family

  dynamic "parameter" {
    for_each = var.elasticache_parameters
    content {
      name  = parameter.key
      value = parameter.value.value
    }
  }

  tags = {
    Name = "${var.project_settings.project_name}-cache-parameter-group"
  }
}
