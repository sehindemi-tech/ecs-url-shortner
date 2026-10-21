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

##Networking Module
variable "vpc_settings" {
  description = "Settings for the url_shortner VPC"
  type = object({
    cidr_block           = string
    enable_dns_support   = bool
    enable_dns_hostnames = bool
  })
}

variable "subnet_settings" {
  description = "Subnet settings for the ecs-url-shortner"
  type = map(object({
    availability_zone       = string
    cidr_block              = string
    map_public_ip_on_launch = bool
    is_public               = bool
  }))
}

variable "interface_endpoints" {
  description = "A map of VPC endpoints to create"
  type        = list(string)
}

variable "vpc_flow_log_settings" {
  description = "VPC flow log settings"
  type = object({
    log_destination_type = string
    traffic_type         = string
  })
}





## Security Module
variable "security_groups" {
  description = "The security groups for the ecs-shortner project"
  type = map(object({
    description = string
    s3_egress   = optional(bool, false)
  }))
}

variable "alb_ingress_rules" {
  description = "The ingress rules for the ALB security group, keyed by rule name."
  type = map(object({
    cidr_ipv4   = string
    description = string
    from_port   = number
    to_port     = number
    ip_protocol = string
  }))
}

variable "sg_flows" {
  description = "TCP flows between security groups, keyed by flow name."
  type = map(object({
    from = string
    to   = string
    port = number
  }))
}

variable "kms_keys" {
  description = "A map of KMS keys to create"
  type = map(object({
    description             = string
    deletion_window_in_days = number
    enable_key_rotation     = bool
    is_enabled              = bool
    actions                 = optional(list(string))
    allow_cloudwatch_logs   = optional(bool, false)
    allow_cloudwatch_alarms = optional(bool, false)
    allow_secrets_manage    = optional(bool, false)
    allow_rds_use           = optional(bool, false)
    allow_redis_use         = optional(bool, false)
    allow_sqs_producer_arns = optional(list(string), [])
    allow_sqs_consumer_arns = optional(list(string), [])
  }))
}


## Monitoring Module
variable "vpc_flow_logs_cloudwatch_log_group" {
  description = "Settings for the CloudWatch log group used by VPC flow logs"
  type = object({
    name                        = string
    retention_in_days           = number
    deletion_protection_enabled = bool
    log_group_class             = string
  })
}

variable "cloudwatch_log_groups" {
  description = "The cloudwatch log groups"
  type = map(object({
    name                        = string
    retention_in_days           = number
    deletion_protection_enabled = bool
    log_group_class             = string
  }))
}

variable "alert_email" {
  description = "Email address to receive CloudWatch alarm notifications"
  type        = string
}

variable "ecs_running_task_alarms" {
  description = "Configuration for ECS running task CloudWatch alarms"
  type = map(object({
    comparison_operator = string
    evaluation_periods  = number
    metric_name         = string
    namespace           = string
    period              = number
    statistic           = string
    threshold           = number
    actions_enabled     = bool
    datapoints_to_alarm = number
    treat_missing_data  = string
  }))
}

variable "dlq_alarm" {
  type = object({
    comparison_operator = string
    evaluation_periods  = number
    metric_name         = string
    namespace           = string
    period              = number
    statistic           = string
    threshold           = number
    actions_enabled     = bool
    datapoints_to_alarm = number
    treat_missing_data  = string
  })
  description = "Configuration for the DLQ CloudWatch alarm"
}



variable "dlq_name" {
  type        = string
  description = "The name of the Dlq"
}

variable "rds_alarm" {
  type = object({
    comparison_operator = string
    evaluation_periods  = number
    metric_name         = string
    namespace           = string
    period              = number
    statistic           = string
    threshold           = number
    actions_enabled     = bool
    datapoints_to_alarm = number
    treat_missing_data  = string
  })
  description = "Configuration for the RDS CloudWatch alarm"
}

variable "db_instance_identifier" {
  type        = string
  description = "The identifier of the RDS DB instance"
}

### ECS Cluster and Service Names
variable "cluster_name" {
  description = "ECS cluster name, as used in the ClusterName metric dimension."
  type        = string
}

variable "ecs_service_names" {
  description = "ECS service names keyed like ecs_running_task_alarms."
  type        = string
}


##Route 53
variable "dashboard_domain_name" {
  description = "The domain name for the dashboard to be included as a subject alternative name in the ACM certificate."
  type        = string
}


####DB
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


###Elastic Cache
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


####SQS

variable "dlq_settings" {
  description = "The Dead Letter Queue settings for the SQS"

  type = object({
    fifo_queue                = bool
    message_retention_seconds = number
  })
}

variable "main_sqs_queue" {
  description = "The main SQS queue settings"
  type = object({
    fifo_queue                 = bool
    message_retention_seconds  = number
    visibility_timeout_seconds = number
  })
}
