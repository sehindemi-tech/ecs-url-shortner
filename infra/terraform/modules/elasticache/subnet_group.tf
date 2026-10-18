resource "aws_elasticache_subnet_group" "elasticache_subnet_group" {
  name        = "${var.project_settings.project_name}-cache-subnet"
  description = "ElastiCache subnet group for the project"
  subnet_ids  = var.private_subnet_ids

  tags = {
    Name = "${var.project_settings.project_name}-cache-subnet"
  }
}


variable "private_subnet_ids" {
  description = "The IDs of the private subnets for the ElastiCache subnet group"
  type        = list(string)
}
