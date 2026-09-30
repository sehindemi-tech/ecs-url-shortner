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

variable "s3_bucket_settings" {
  description = "The S3 bucket settings for the project"
  type = map(object({
    name          = string
    force_destroy = optional(bool, false)
    description   = optional(string)
    versioning    = optional(bool, true)
    sse_algorithm = optional(string, "aws:kms")
  }))
}

variable "bootstrap_s3_kms_key" {
  description = "The KMS key settings for the bootstrap S3 bucket"
  type = object({
    description             = optional(string)
    deletion_window_in_days = optional(number, 7)
    enable_key_rotation     = optional(bool, true)
    alias_name              = string
  })
}

variable "ecr_repositories" {
  description = "ECR repository settings"
  type = map(object({
    image_tag_mutability = optional(string, "IMMUTABLE")
    force_delete         = optional(bool, false)
    encryption_type      = optional(string, "AES256")
    scan_on_push         = optional(bool, true)
  }))
  validation {
    condition     = alltrue([for r in var.ecr_repositories : r.image_tag_mutability == "IMMUTABLE"])
    error_message = "All repositories must be IMMUTABLE."
  }
}
