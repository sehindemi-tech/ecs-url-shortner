resource "aws_cloudwatch_log_group" "vpc_flow_log" {
  name                        = var.vpc_flow_logs_cloudwatch_log_group.name
  retention_in_days           = var.vpc_flow_logs_cloudwatch_log_group.retention_in_days
  deletion_protection_enabled = var.vpc_flow_logs_cloudwatch_log_group.deletion_protection_enabled
  log_group_class             = var.vpc_flow_logs_cloudwatch_log_group.log_group_class
  tags = {
    Environment = var.project_settings.environment
    Application = var.project_settings.project_name
  }
}
