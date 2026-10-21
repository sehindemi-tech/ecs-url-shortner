variable "project_settings" {
  description = "The Project setting for the url-shortner"

  type = object({
    aws_region                 = string
    github_org                 = string
    project_name               = string
    github_repo                = string
    environment                = string
    github_repository_id       = string
    github_repository_owner_id = string
  })
}

variable "dlq_settings" {
  description = "The Dead Letter Queue settings for the SQS"

  type = object({
    fifo_queue                = bool
    message_retention_seconds = number
  })
}

variable "sqs_kms_key_id" {
  description = "The KMS key ID for the SQS queue"
  type        = string
}


variable "main_sqs_queue" {
  description = "The main SQS queue settings"
  type = object({
    fifo_queue                 = bool
    message_retention_seconds  = number
    visibility_timeout_seconds = number
  })
}
