# resource "aws_lb" "this" {
#   name_prefix        = "${var.project_settings.project_name}-${var.project_settings.environment}-alb"
#   enable_cross_zone_load_balancing = var.alb_settings.enable_cross_zone_load_balancing
#   enable_deletion_protection = var.alb_settings.enable_deletion_protection
#   enable_http2 = var.alb_settings.enable_http2
#   enable_zonal_shift = var.alb_settings.enable_zonal_shift
#   idle_timeout {
#     timeout_seconds = var.alb_settings.idle_timeout_seconds
#   }
#   health_check_log {
#     enabled = var.alb_settings.health_check_log_enabled
#     bucket  = var.alb_settings.health_check_log_bucket
#     prefix  = var.alb_settings.health_check_log_prefix
#   }
#   access_logs {
#     bucket  = var.alb_settings.access_logs_bucket
#     enabled = var.alb_settings.access_logs_enabled
#     prefix  = var.alb_settings.access_logs_prefix
#   }
#   connection_logs {
#     bucket  = var.alb_settings.connection_logs_bucket
#     enabled = var.alb_settings.connection_logs_enabled
#     prefix  = var.alb_settings.connection_logs_prefix
#   }
#   internal           = var.alb_settings.internal
#   ip_address_type     = var.alb_settings.ip_address_type
#   load_balancer_type = var.alb_settings.load_balancer_type
#   minimum_load_balancer_capacity = var.alb_settings.minimum_load_balancer_capacity
#   security_groups    = var.alb_security_groups
#   subnets            = var.public_subnets
# }

# variable "alb_security_groups" {
#   description = "Security groups for the ALB"
#   type        = list(string)
# }

# variable "public_subnets" {
#   description = "Subnets for the ALB"
#   type        = list(string)
# }
# variable "alb_settings" {
#   description = "Settings for the ALB"
#   type = object({
#     internal                        = bool
#     access_logs_bucket              = string
#     access_logs_enabled             = bool
#     connection_logs_bucket          = string
#     connection_logs_enabled         = bool
#     connection_logs_prefix          = string
#     enable_cross_zone_load_balancing = bool
#     enable_deletion_protection      = bool
#     enable_http2                     = bool
#     enable_zonal_shift               = bool
#     idle_timeout_seconds             = number
#     ip_address_type                  = string
#     health_check_log_enabled         = bool
#     health_check_log_bucket          = string
#     health_check_log_prefix          = string
#     load_balancer_type               = string
#     minimum_load_balancer_capacity   = number
#     access_logs_prefix              = string
#   })
# }

# alb_settings = {
#   access_logs_prefix              = "my-access-logs-prefix"
#   internal                        = false
#   access_logs_bucket              = "my-access-logs-bucket"
#   access_logs_enabled             = true
#   connection_logs_bucket          = "my-connection-logs-bucket"
#   connection_logs_enabled         = true
#   connection_logs_prefix          = "my-connection-logs-prefix"
#   enable_cross_zone_load_balancing = true
#   enable_deletion_protection      = false
#   enable_http2                     = true
#   enable_zonal_shift               = true
#   idle_timeout_seconds             = 60
#   ip_address_type                  = "ipv4"
#   health_check_log_enabled         = true
#   load_balancer_type               = "application"
#   minimum_load_balancer_capacity   = 1
# }
