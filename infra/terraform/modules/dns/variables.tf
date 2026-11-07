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

variable "dashboard_domain_name" {
  description = "The domain name for the dashboard to be included as a subject alternative name in the ACM certificate."
  type        = string
}

variable "alb_settings" {
  description = "ALB settings"
  type = object({
    dns_name = string
    zone_id  = string
  })
}

variable "records" {
  description = "Map of DNS records"
  type = map(object({
    name = string
    type = string
  }))
}
