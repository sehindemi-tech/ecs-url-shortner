resource "random_password" "db_pass" {
  length  = 32
  special = false
}

resource "aws_secretsmanager_secret" "rds_secrets" {
  description             = "The secret storing the database URL"
  kms_key_id              = var.secrets_manager_kms_arn
  name_prefix             = "${var.db_instance.identifier}-${var.project_settings.environment}-database-url-"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "rds_secrets" {
  secret_id = aws_secretsmanager_secret.rds_secrets.id

  secret_string = jsonencode({
    DATABASE_URL = "postgresql://${var.db_instance.username}:${random_password.db_pass.result}@${aws_db_instance.this.address}:${aws_db_instance.this.port}/${aws_db_instance.this.db_name}?sslmode=require"
  })
}
