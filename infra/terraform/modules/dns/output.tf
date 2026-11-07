output "acm_arn" {
  description = "ARN of the ACM certificate for the HTTPS listener"
  value       = aws_acm_certificate.this.arn
}
