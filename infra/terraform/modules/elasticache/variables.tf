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

variable "elastic_cache_kms_arn" {
  description = "The KMS key ARN for encrypting ElastiCache at rest"
  type        = string
}

variable "elasticache_security_group_ids" {
  description = "The security group IDs for the ElastiCache replication group"
  type        = list(string)
}

variable "elasticache_replication_group" {
  description = "The ElastiCache replication group configuration"
  type = object({
    replication_group_description = string
    apply_immediately             = bool
    at_rest_encryption_enabled    = bool
    auth_token_update_strategy    = string
    auto_minor_version_upgrade    = bool
    engine                        = string
    engine_version                = string
    ip_discovery                  = string
    maintenance_window            = string
    multi_az_enabled              = bool
    network_type                  = string
    num_cache_clusters            = number
    node_type                     = string
    port                          = number
    transit_encryption_enabled    = bool
    transit_encryption_mode       = string
    automatic_failover_enabled    = bool
  })
}
