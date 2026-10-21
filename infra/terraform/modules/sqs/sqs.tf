resource "aws_sqs_queue" "main_sqs" {
  name_prefix = "${var.project_settings.project_name}-${var.project_settings.environment}-queue-"

  fifo_queue                 = var.main_sqs_queue.fifo_queue
  kms_master_key_id          = var.sqs_kms_key_id
  message_retention_seconds  = var.main_sqs_queue.message_retention_seconds
  visibility_timeout_seconds = var.main_sqs_queue.visibility_timeout_seconds

  tags = {
    Project     = var.project_settings.project_name
    Environment = var.project_settings.environment
  }

  lifecycle {
    create_before_destroy = true
  }
}



resource "aws_sqs_queue" "dlq_sqs" {
  name_prefix = "${var.project_settings.project_name}-${var.project_settings.environment}-dlq-queue-"

  fifo_queue                = var.dlq_settings.fifo_queue
  kms_master_key_id         = var.sqs_kms_key_id
  message_retention_seconds = var.dlq_settings.message_retention_seconds

  tags = {
    Project     = var.project_settings.project_name
    Environment = var.project_settings.environment
  }

  lifecycle {
    create_before_destroy = true
  }
}
