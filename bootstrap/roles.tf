resource "aws_iam_role" "terraform_oidc_roles" {
  for_each = var.cicd_roles

  name               = "${var.project_settings.project_name}-${each.key}"
  description        = each.value.description
  assume_role_policy = data.aws_iam_policy_document.terraform_oidc_roles_assume_role_policy[each.key].json
}

resource "aws_iam_role_policy" "this" {
  for_each = var.cicd_roles
  role     = aws_iam_role.terraform_oidc_roles[each.key].id
  policy   = data.aws_iam_policy_document.role_policies[each.key].json
}
#trivy:ignore:AVD-AWS-0345 will clean actions later
data "aws_iam_policy_document" "role_policies" {
  for_each = var.cicd_roles
  statement {
    effect = "Allow"
    actions = [
      "ec2:*",
      "iam:*",
      "kms:*",
      "rds:*",
      "s3:*",
      "logs:*",
      "ecr:*",
      "sts:GetCallerIdentity",
      "route53:*",
      "sqs:*",
      "ssm:*"
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "terraform_oidc_roles_assume_role_policy" {
  for_each = var.cicd_roles
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]
    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.this.arn]
    }
    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = [each.value.sub_values]
    }
  }
}

variable "cicd_roles" {
  description = "CICD roles using OIDC"
  type = map(object({
    description = string
    sub_values  = string
  }))
}
