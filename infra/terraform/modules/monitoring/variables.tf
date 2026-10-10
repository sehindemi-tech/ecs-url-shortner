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

variable "cloudwatch_log_groups" {
  description = "The cloudwatch log groups"
  type = map(object({
    name                        = string
    retention_in_days           = number
    deletion_protection_enabled = bool
    log_group_class             = string
  }))
}

variable "kms_key_arn" {
  description = "The ARN of the KMS key to use for encrypting CloudWatch log groups"
  type        = string
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

variable "cluster_name" {
  description = "ECS cluster name, as used in the ClusterName metric dimension."
  type        = string
}

variable "ecs_service_names" {
  description = "ECS service names keyed like ecs_running_task_alarms."
  type        = string
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
