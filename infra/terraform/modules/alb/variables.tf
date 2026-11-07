variable "project_settings" {
  description = "The Project setting for the url-shortner"
  type = object({
    aws_region                 = string
    github_org                 = string
    project_name               = string
    github_repo                = string
    environment                = string
    github_repository_id       = string
    github_repository_owner_id = string
  })
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}


variable "s3_access_logs_setting" {
  description = "Settings for the S3 access logs bucket"
  type = object({
    s3_bucket = object({
      force_destroy = bool
    })
    sse_encrytption = object({
      sse_algorithm = string
    })
    lifecycle = object({
      id                                     = string
      status                                 = string
      noncurrent_days                        = number
      newer_noncurrent_versions              = number
      abort_incomplete_multipart_upload_days = number
      expiration_days                        = number
      transition_default_minimum_object_size = string
    })
  })
}

variable "alb_security_groups" {
  description = "Security groups for the ALB"
  type        = list(string)
}

variable "public_subnets" {
  description = "Subnets for the ALB"
  type        = list(string)
}

variable "alb_settings" {
  description = "Settings for the ALB"
  type = object({
    internal                         = bool
    ip_address_type                  = string
    load_balancer_type               = string
    drop_invalid_header_fields       = bool
    enable_cross_zone_load_balancing = bool
    enable_deletion_protection       = bool
    enable_http2                     = bool
    enable_zonal_shift               = bool
    idle_timeout_seconds             = number
    health_check_log_enabled         = bool
    access_logs_enabled              = bool
    connection_logs_enabled          = bool
  })
}

variable "target_group_name_prefix" {
  description = "Prefix for the target group names"
  type        = string
}

variable "target_groups" {
  description = "Target groups for the ALB"
  type = map(object({
    port                              = number
    protocol                          = string
    target_type                       = string
    ip_address_type                   = string
    deregistration_delay              = number
    load_balancing_algorithm_type     = string
    load_balancing_cross_zone_enabled = bool
  }))
}

variable "health_check" {
  description = "Health check settings for the target groups"
  type = object({
    healthy_threshold   = number
    unhealthy_threshold = number
    interval            = number
    timeout             = number
    path                = string
    matcher             = string
    port                = string
    protocol            = string
  })
}

variable "http_listener" {
  description = "HTTP listener for the ALB"
  type = object({
    port                = number
    protocol            = string
    default_action_type = string
    redirect = object({
      protocol    = string
      port        = number
      status_code = string
    })
  })
}

variable "acm_arn" {
  description = "ARN of the ACM certificate for the HTTPS listener"
  type        = string
}

variable "https_listener" {
  description = "HTTPS listener for the ALB"
  type = object({
    port                = number
    protocol            = string
    ssl_policy          = string
    default_action_type = string
  })
}


variable "test_listener" {
  description = "Test listener rule"
  type = object({
    port                = number
    protocol            = string
    ssl_policy          = string
    default_action_type = string
  })
}

variable "listener_rules" {
  description = "Map of listener rules"
  type = map(object({
    priority           = number
    blue_target_group  = string
    green_target_group = string
    host               = string
  }))
}
