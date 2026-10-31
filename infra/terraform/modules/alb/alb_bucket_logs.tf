resource "aws_s3_bucket" "access_logs" {
  bucket_prefix = "${var.project_settings.project_name}-access-logs-"
  force_destroy = var.s3_access_logs_setting.s3_bucket.force_destroy
  tags = {
    Name = "${var.project_settings.project_name}-access-logs"
  }
}

resource "aws_s3_bucket_public_access_block" "access_logs" {
  bucket = aws_s3_bucket.access_logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

#trivy:ignore:AWS-0132 AES needed ALB
resource "aws_s3_bucket_server_side_encryption_configuration" "access_logs" {
  bucket = aws_s3_bucket.access_logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = var.s3_access_logs_setting.sse_encrytption.sse_algorithm
    }
  }
}


resource "aws_s3_bucket_lifecycle_configuration" "access_logs" {
  bucket                                 = aws_s3_bucket.access_logs.id
  transition_default_minimum_object_size = var.s3_access_logs_setting.lifecycle.transition_default_minimum_object_size

  rule {
    id     = var.s3_access_logs_setting.lifecycle.id
    status = var.s3_access_logs_setting.lifecycle.status

    noncurrent_version_expiration {
      noncurrent_days           = var.s3_access_logs_setting.lifecycle.noncurrent_days
      newer_noncurrent_versions = var.s3_access_logs_setting.lifecycle.newer_noncurrent_versions
    }

    abort_incomplete_multipart_upload {
      days_after_initiation = var.s3_access_logs_setting.lifecycle.abort_incomplete_multipart_upload_days
    }

    expiration {
      days = var.s3_access_logs_setting.lifecycle.expiration_days
    }
  }
}

resource "aws_s3_bucket_policy" "access_logs" {
  bucket = aws_s3_bucket.access_logs.id
  policy = data.aws_iam_policy_document.access_logs.json
}

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
      "${aws_s3_bucket.access_logs.arn}/${var.project_settings.project_name}-access-logs/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
    ]

    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values   = ["arn:aws:elasticloadbalancing:${var.project_settings.aws_region}:${data.aws_caller_identity.current.account_id}:loadbalancer/*"]
    }
  }
}
