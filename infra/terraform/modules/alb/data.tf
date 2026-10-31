data "aws_caller_identity" "current" {}


data "aws_iam_policy_document" "access_logs" {
  statement {
    sid    = "AllowALBLogDelivery"
    effect = "Allow"
    actions = [
      "s3:PutObject"
    ]

    principals {
      type        = "Service"
      identifiers = ["logdelivery.elasticloadbalancing.amazonaws.com"]
    }

    resources = [
      "${aws_s3_bucket.access_logs.arn}/${var.project_settings.project_name}-access-logs/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
      "${aws_s3_bucket.access_logs.arn}/${var.project_settings.project_name}-health-check-logs/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
      "${aws_s3_bucket.access_logs.arn}/${var.project_settings.project_name}-connection-logs/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
    ]

    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values   = ["arn:aws:elasticloadbalancing:${var.project_settings.aws_region}:${data.aws_caller_identity.current.account_id}:loadbalancer/*"]
    }
  }
}
