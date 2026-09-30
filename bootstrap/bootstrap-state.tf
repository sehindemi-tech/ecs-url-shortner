resource "aws_s3_bucket" "terraform_states" {
  for_each = var.s3_bucket_settings

  bucket        = "${each.key}-${data.aws_caller_identity.current.account_id}"
  force_destroy = each.value.force_destroy

  tags = {
    Description = each.value.description
    ManagedBy   = "Terraform"
    Project     = var.project_settings.project_name
  }
}

resource "aws_s3_bucket_versioning" "terraform_states_versioning" {
  for_each = var.s3_bucket_settings

  bucket = aws_s3_bucket.terraform_states[each.key].id
  versioning_configuration {
    status = each.value.versioning ? "Enabled" : "Suspended"
  }
}

resource "aws_s3_bucket_public_access_block" "terraform_state_public_access_block" {
  for_each = var.s3_bucket_settings

  bucket                  = aws_s3_bucket.terraform_states[each.key].id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


resource "aws_kms_key" "bootstrap_s3_kms_key" {
  description             = var.bootstrap_s3_kms_key.description
  deletion_window_in_days = var.bootstrap_s3_kms_key.deletion_window_in_days
  enable_key_rotation     = var.bootstrap_s3_kms_key.enable_key_rotation
  policy                  = data.aws_iam_policy_document.s3_bootstrap_kms_key.json

  tags = {
    Name = "${var.project_settings.project_name}-bootstrap-s3-kms-key"
  }
}
resource "aws_kms_alias" "bootstrap_s3_kms_alias" {
  name          = var.bootstrap_s3_kms_key.alias_name
  target_key_id = aws_kms_key.bootstrap_s3_kms_key.key_id
}

resource "aws_s3_bucket_server_side_encryption_configuration" "server_side_kms" {
  for_each = var.s3_bucket_settings

  bucket = aws_s3_bucket.terraform_states[each.key].id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = each.value.sse_algorithm
      kms_master_key_id = aws_kms_key.bootstrap_s3_kms_key.key_id
    }
  }
}
