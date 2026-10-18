output "redis_url_secret_arn" {
  description = "The ARN of the Redis URL secret in AWS Secrets Manager"
  value       = aws_secretsmanager_secret.redis_url.arn
}
