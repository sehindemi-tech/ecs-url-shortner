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


### ECS Cluster and Service Names
variable "cluster_name" {
  description = "ECS cluster name, as used in the ClusterName metric dimension."
  type        = string
}

variable "ecs_service_names" {
  description = "ECS service names keyed like ecs_running_task_alarms."
  type        = string
}
