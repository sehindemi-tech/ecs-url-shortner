resource "aws_sns_topic" "this" {
  name              = "${var.project_settings.project_name}-alerts"
  display_name      = "${var.project_settings.project_name} Alerts"
  kms_master_key_id = var.kms_key_arn
}

resource "aws_sns_topic_subscription" "this" {
  topic_arn = aws_sns_topic.this.arn
  protocol  = "email"
  endpoint  = var.alert_email
}
