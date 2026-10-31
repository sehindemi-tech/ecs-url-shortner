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
