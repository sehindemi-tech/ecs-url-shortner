##False positive for Trivy AVD-AWS-0045 and AVD-AWS-0051
#trivy:ignore:AVD-AWS-0045
#trivy:ignore:AVD-AWS-0051
resource "aws_elasticache_replication_group" "aws_elasticache_replication_group" {
  replication_group_id = "${var.project_settings.project_name}-replication-group"
  description          = var.elasticache_replication_group.replication_group_description

  engine               = var.elasticache_replication_group.engine
  engine_version       = var.elasticache_replication_group.engine_version
  node_type            = var.elasticache_replication_group.node_type
  port                 = var.elasticache_replication_group.port
  parameter_group_name = aws_elasticache_parameter_group.elasticache_parameter_group.name

  num_cache_clusters         = var.elasticache_replication_group.num_cache_clusters
  automatic_failover_enabled = var.elasticache_replication_group.automatic_failover_enabled
  multi_az_enabled           = var.elasticache_replication_group.multi_az_enabled

  subnet_group_name  = aws_elasticache_subnet_group.elasticache_subnet_group.name
  security_group_ids = var.elasticache_security_group_ids
  network_type       = var.elasticache_replication_group.network_type
  ip_discovery       = var.elasticache_replication_group.ip_discovery

  at_rest_encryption_enabled = var.elasticache_replication_group.at_rest_encryption_enabled
  kms_key_id                 = var.elastic_cache_kms_arn
  transit_encryption_enabled = var.elasticache_replication_group.transit_encryption_enabled
  transit_encryption_mode    = var.elasticache_replication_group.transit_encryption_mode
  auth_token                 = random_password.auth.result
  auth_token_update_strategy = var.elasticache_replication_group.auth_token_update_strategy

  maintenance_window         = var.elasticache_replication_group.maintenance_window
  auto_minor_version_upgrade = var.elasticache_replication_group.auto_minor_version_upgrade
  apply_immediately          = var.elasticache_replication_group.apply_immediately
}
