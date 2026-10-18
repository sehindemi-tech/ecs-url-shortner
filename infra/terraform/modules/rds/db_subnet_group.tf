resource "aws_db_subnet_group" "this" {
  name       = "${var.project_settings.project_name}-${var.project_settings.environment}-db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name        = "${var.project_settings.project_name}-${var.project_settings.environment}-db-subnet-group"
    Environment = var.project_settings.environment
  }
}
