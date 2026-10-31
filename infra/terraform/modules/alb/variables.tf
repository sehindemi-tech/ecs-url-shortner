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

# variable "vpc_id" {
#   description = "The ID of the VPC"
#   type        = string
# }


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
