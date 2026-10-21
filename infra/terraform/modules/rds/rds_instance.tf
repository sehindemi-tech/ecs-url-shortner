resource "aws_db_instance" "this" {
  allocated_storage               = var.db_instance.allocated_storage
  allow_major_version_upgrade     = var.db_instance.allow_major_version_upgrade
  apply_immediately               = var.db_instance.apply_immediately
  auto_minor_version_upgrade      = var.db_instance.auto_minor_version_upgrade
  backup_retention_period         = var.db_instance.backup_retention_period
  database_insights_mode          = var.db_instance.database_insights_mode
  db_name                         = "${var.db_instance.db_name}_${var.project_settings.environment}"
  db_subnet_group_name            = aws_db_subnet_group.this.name
  deletion_protection             = var.db_instance.deletion_protection
  enabled_cloudwatch_logs_exports = var.db_instance.enabled_cloudwatch_logs_exports
  engine                          = var.db_instance.engine
  engine_version                  = var.db_instance.engine_version
  identifier_prefix               = "${var.db_instance.identifier}-${var.project_settings.environment}-"
  instance_class                  = var.db_instance.instance_class
  kms_key_id                      = var.rds_kms_arn
  maintenance_window              = var.db_instance.maintenance_window
  max_allocated_storage           = var.db_instance.max_allocated_storage
  # multi_az = var.db_instance.multi_az
  network_type           = var.db_instance.network_type
  parameter_group_name   = aws_db_parameter_group.this.name
  port                   = var.db_instance.port
  publicly_accessible    = var.db_instance.publicly_accessible
  skip_final_snapshot    = var.db_instance.skip_final_snapshot
  storage_encrypted      = var.db_instance.storage_encrypted
  storage_type           = var.db_instance.storage_type
  username               = var.db_instance.username
  password               = random_password.db_pass.result
  vpc_security_group_ids = var.rds_security_group_ids


}
