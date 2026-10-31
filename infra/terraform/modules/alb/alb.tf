#trivy:ignore:AWS-0053 ALB needs to be publicly accessible
resource "aws_lb" "this" {
  name                             = "${var.project_settings.project_name}-${var.project_settings.environment}-alb"
  internal                         = var.alb_settings.internal
  ip_address_type                  = var.alb_settings.ip_address_type
  load_balancer_type               = var.alb_settings.load_balancer_type
  security_groups                  = var.alb_security_groups
  subnets                          = var.public_subnets
  enable_cross_zone_load_balancing = var.alb_settings.enable_cross_zone_load_balancing
  enable_deletion_protection       = var.alb_settings.enable_deletion_protection
  enable_http2                     = var.alb_settings.enable_http2
  enable_zonal_shift               = var.alb_settings.enable_zonal_shift
  drop_invalid_header_fields       = var.alb_settings.drop_invalid_header_fields



  idle_timeout = var.alb_settings.idle_timeout_seconds

  health_check_logs {
    bucket  = aws_s3_bucket.access_logs.id
    enabled = var.alb_settings.health_check_log_enabled
    prefix  = "${var.project_settings.project_name}-health-check-logs"
  }

  access_logs {
    bucket  = aws_s3_bucket.access_logs.id
    enabled = var.alb_settings.access_logs_enabled
    prefix  = "${var.project_settings.project_name}-access-logs"
  }

  connection_logs {
    bucket  = aws_s3_bucket.access_logs.id
    enabled = var.alb_settings.connection_logs_enabled
    prefix  = "${var.project_settings.project_name}-connection-logs"
  }

  depends_on = [aws_s3_bucket.access_logs]
}
