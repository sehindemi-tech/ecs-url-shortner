output "sqs_queue_arn" {
  description = "The ARN of the main SQS queue"
  value       = aws_sqs_queue.main_sqs.arn
}

output "sqs_queue_url" {
  description = "The URL of the main SQS queue"
  value       = aws_sqs_queue.main_sqs.id
}

output "dlq_sqs_queue_arn" {
  description = "The ARN of the dead-letter SQS queue"
  value       = aws_sqs_queue.dlq_sqs.arn
}

output "dlq_sqs_queue_url" {
  description = "The URL of the dead-letter SQS queue"
  value       = aws_sqs_queue.dlq_sqs.id
}

output "sqs_queue_name" {
  description = "The name of the main SQS queue"
  value       = aws_sqs_queue.main_sqs.name
}

output "dlq_sqs_queue_name" {
  description = "The name of the dead-letter SQS queue"
  value       = aws_sqs_queue.dlq_sqs.name
}
