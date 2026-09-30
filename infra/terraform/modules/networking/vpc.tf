resource "aws_vpc" "url_shortner" {
  cidr_block           = var.vpc_settings.cidr_block
  enable_dns_support   = var.vpc_settings.enable_dns_support
  enable_dns_hostnames = var.vpc_settings.enable_dns_hostnames
}
