resource "aws_kms_key" "this" {
  for_each = var.kms_keys

  description             = each.value.description
  deletion_window_in_days = each.value.deletion_window_in_days
  enable_key_rotation     = each.value.enable_key_rotation
  is_enabled              = each.value.is_enabled
  policy                  = data.aws_iam_policy_document.this[each.key].json
}


data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "this" {
  for_each = var.kms_keys

  statement {
    sid       = "AllowRootAccount"
    effect    = "Allow"
    actions   = ["kms:*"]
    resources = ["*"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }

  dynamic "statement" {
    for_each = length(lookup(var.key_role_arns, each.key, [])) > 0 ? [1] : []

    content {
      sid       = "AllowNamedRoles"
      effect    = "Allow"
      actions   = each.value.actions
      resources = ["*"]

      principals {
        type        = "AWS"
        identifiers = lookup(var.key_role_arns, each.key, [])
      }
    }
  }

  dynamic "statement" {
    for_each = each.value.allow_cloudwatch_logs ? [1] : []

    content {
      sid       = "AllowCloudWatchLogs"
      effect    = "Allow"
      actions   = each.value.actions
      resources = ["*"]

      principals {
        type        = "Service"
        identifiers = ["logs.${var.project_settings.aws_region}.amazonaws.com"]
      }

      condition {
        test     = "ArnLike"
        variable = "kms:EncryptionContext:aws:logs:arn"
        values   = ["arn:aws:logs:${var.project_settings.aws_region}:${data.aws_caller_identity.current.account_id}:*"]
      }
    }
  }

  dynamic "statement" {
    for_each = each.value.allow_cloudwatch_alarms ? [1] : []

    content {
      sid    = "AllowCloudWatchAlarms"
      effect = "Allow"
      actions = [
        "kms:Decrypt",
        "kms:GenerateDataKey"
      ]
      resources = ["*"]

      principals {
        type        = "Service"
        identifiers = ["cloudwatch.amazonaws.com"]
      }
      condition {
        test     = "StringEquals"
        variable = "aws:SourceAccount"
        values   = [data.aws_caller_identity.current.account_id]
      }
    }
  }
}

resource "aws_kms_alias" "this" {
  for_each = var.kms_keys

  name          = "alias/${each.key}"
  target_key_id = aws_kms_key.this[each.key].id
}
