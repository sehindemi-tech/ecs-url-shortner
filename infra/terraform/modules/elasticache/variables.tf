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

variable "elasticache_family" {
  description = "The family of the ElastiCache parameter group"
  type        = string
}

variable "elasticache_parameters" {
  description = "The parameters for the ElastiCache parameter group"
  type = map(object({
    value = string
  }))
}
