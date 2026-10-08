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
variable "vpc_flow_logs_cloudwatch_log_group" {
  description = "Settings for the CloudWatch log group used by VPC flow logs"
  type = object({
    name                        = string
    retention_in_days           = number
    deletion_protection_enabled = bool
    log_group_class             = string
  })
}
