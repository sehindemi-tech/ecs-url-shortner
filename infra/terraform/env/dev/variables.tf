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
