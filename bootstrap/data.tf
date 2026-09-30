
data "aws_caller_identity" "current" {}


data "aws_iam_policy_document" "s3_bootstrap_kms_key" {
  statement {
    sid    = "EnableRootAccountAdmin"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }

    actions   = ["kms:*"]
    resources = ["*"]
  }

  # statement {
  #   sid    = "AllowTerraformRoleKeyManagement"
  #   effect = "Allow"
  #   principals {
  #     type        = "AWS"
  #     identifiers = var.bootstrap_role_arns
  #   }

  #   actions = [
  #     "kms:DescribeKey",
  #     "kms:CreateGrant",
  #     "kms:ListGrants",
  #     "kms:RevokeGrant",
  #   ]

  #   resources = ["*"]
  # }
}


data "aws_ecr_lifecycle_policy_document" "ecr_shortener_repos_lifecycle_policy" {
  rule {
    priority    = 1
    description = "Expire untagged images after 7 days"

    selection {
      tag_status   = "untagged"
      count_type   = "sinceImagePushed"
      count_unit   = "days"
      count_number = 7
    }

    action {
      type = "expire"
    }
  }

  rule {
    priority    = 2
    description = "Keep last 10 sha- tagged images"

    selection {
      tag_status       = "tagged"
      tag_pattern_list = ["sha-*"]
      count_type       = "imageCountMoreThan"
      count_number     = 10
    }

    action {
      type = "expire"
    }
  }
}
