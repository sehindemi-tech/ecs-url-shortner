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
      sid    = "AllowCloudWatchLogs"
      effect = "Allow"
      actions = [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:Describe*",
      ]
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
        "kms:GenerateDataKey*",
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

  dynamic "statement" {
    for_each = each.value.allow_secrets_manage ? [1] : []

    content {
      sid    = "AllowSecretsManagerViaService"
      effect = "Allow"
      actions = [
        "kms:Decrypt",
        "kms:Encrypt",
        "kms:GenerateDataKey",
      ]
      resources = ["*"]

      principals {
        type        = "AWS"
        identifiers = ["*"]
      }

      condition {
        test     = "StringEquals"
        variable = "kms:CallerAccount"
        values   = [data.aws_caller_identity.current.account_id]
      }

      condition {
        test     = "StringEquals"
        variable = "kms:ViaService"
        values   = ["secretsmanager.${var.project_settings.aws_region}.amazonaws.com"]
      }


    }
  }

  dynamic "statement" {
    for_each = each.value.allow_rds_use ? [1] : []

    content {
      sid    = "AllowRdsViaService"
      effect = "Allow"
      actions = [
        "kms:CreateGrant",
        "kms:DescribeKey"
      ]
      resources = ["*"]

      principals {
        type        = "AWS"
        identifiers = ["*"]
      }

      condition {
        test     = "StringEquals"
        variable = "kms:CallerAccount"
        values   = [data.aws_caller_identity.current.account_id]
      }

      condition {
        test     = "StringEquals"
        variable = "kms:ViaService"
        values   = ["rds.eu-west-2.amazonaws.com"]
      }
    }
  }

  dynamic "statement" {
    for_each = each.value.allow_redis_use ? [1] : []

    content {
      sid    = "AllowRedisViaService"
      effect = "Allow"
      actions = [
        "kms:CreateGrant",
        "kms:DescribeKey"
      ]
      resources = ["*"]

      principals {
        type        = "AWS"
        identifiers = ["*"]
      }

      condition {
        test     = "StringEquals"
        variable = "kms:CallerAccount"
        values   = [data.aws_caller_identity.current.account_id]
      }

      condition {
        test     = "StringEquals"
        variable = "kms:ViaService"
        values = [
          "elasticache.eu-west-2.amazonaws.com",
          "dax.eu-west-2.amazonaws.com"
        ]
      }
    }
  }
}
