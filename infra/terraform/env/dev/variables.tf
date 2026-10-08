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
  }))
}

variable "key_role_arns" {
  description = "A map of KMS key names to the ARNs of IAM roles that should have access"
  type        = map(list(string))
  default     = {}
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
