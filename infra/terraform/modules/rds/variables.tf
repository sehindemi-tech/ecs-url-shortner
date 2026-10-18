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

variable "private_subnet_ids" {
  description = "The IDs of the private subnets for the RDS DB subnet group"
  type        = list(string)
}

variable "db_parameters" {
  description = "PostgreSQL parameters  for the RDS DB parameter group"

  type = map(object({
    value        = string
    apply_method = string
  }))
}

variable "db_parameter_group_family" {
  description = "The RDS DB parameter group family"
  type        = string
}


variable "rds_kms_arn" {
  description = "The KMS key ID for the RDS instance"
  type        = string
}


variable "rds_security_group_ids" {
  description = "List of security group IDs to associate with the RDS instance"
  type        = list(string)
}

variable "db_instance" {
  description = "The configuration for the RDS DB instance"
  type = object({
    skip_final_snapshot             = bool
    allocated_storage               = number
    allow_major_version_upgrade     = bool
    apply_immediately               = bool
    auto_minor_version_upgrade      = bool
    backup_retention_period         = number
    database_insights_mode          = string
    db_name                         = string
    deletion_protection             = bool
    enabled_cloudwatch_logs_exports = list(string)
    engine                          = string
    engine_version                  = string
    identifier                      = string
    instance_class                  = string
    maintenance_window              = string
    max_allocated_storage           = number
    # multi_az = bool
    network_type        = string
    port                = number
    publicly_accessible = bool
    storage_encrypted   = bool
    storage_type        = string
    username            = string
  })
}

variable "secrets_manager_kms_arn" {
  description = "The KMS key ARN for the Secrets Manager secret"
  type        = string
}
