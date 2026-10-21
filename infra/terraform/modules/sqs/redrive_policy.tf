resource "aws_sqs_queue_redrive_policy" "main_sqs_redrive_policy" {
  queue_url = aws_sqs_queue.main_sqs.id

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq_sqs.arn
    maxReceiveCount     = 3
  })
}

resource "aws_sqs_queue_redrive_allow_policy" "main_sqs_redrive_policy" {
  queue_url = aws_sqs_queue.main_sqs.id

  redrive_allow_policy = jsonencode({
    redrivePermission = "byQueue"
    sourceQueueArns   = [aws_sqs_queue.dlq_sqs.arn]
  })
}
