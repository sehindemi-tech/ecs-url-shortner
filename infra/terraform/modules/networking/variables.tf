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

variable "vpc_endpoint_security_group_id" {
  description = "The security group ID to associate with interface VPC endpoints"
  type        = string
}

variable "vpc_flow_log_settings" {
  description = "VPC flow log settings"
  type = object({
    log_destination      = string
    log_destination_type = string
    traffic_type         = string
  })
}
