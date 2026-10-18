resource "aws_kms_key" "this" {
  for_each = var.kms_keys

  description             = each.value.description
  deletion_window_in_days = each.value.deletion_window_in_days
  enable_key_rotation     = each.value.enable_key_rotation
  is_enabled              = each.value.is_enabled
  policy                  = data.aws_iam_policy_document.this[each.key].json
}

resource "aws_kms_alias" "this" {
  for_each = var.kms_keys

  name          = "alias/${each.key}"
  target_key_id = aws_kms_key.this[each.key].id
}
