resource "aws_secretsmanager_secret" "redis_url" {
  name_prefix             = "${var.project_settings.project_name}-redis-url-secret-"
  description             = "Redis URL secret for ${var.project_settings.project_name}"
  recovery_window_in_days = 0
  kms_key_id              = var.secrets_manager_kms_arn
}

resource "aws_secretsmanager_secret_version" "redis_url" {
  secret_id = aws_secretsmanager_secret.redis_url.id

  secret_string = jsonencode({
    REDIS_URL = "rediss://:${random_password.auth.result}@${aws_elasticache_replication_group.aws_elasticache_replication_group.primary_endpoint_address}:${aws_elasticache_replication_group.aws_elasticache_replication_group.port}"
  })
}
