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

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

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

variable "s3_prefix_list_id" {
  description = "The prefix list ID for the S3 gateway endpoint."
  type        = string
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
}
