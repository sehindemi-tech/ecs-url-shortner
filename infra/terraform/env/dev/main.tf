module "networking" {
  source                         = "../../modules/networking"
  vpc_settings                   = var.vpc_settings
  subnet_settings                = var.subnet_settings
  project_settings               = var.project_settings
  interface_endpoints            = var.interface_endpoints
  vpc_endpoint_security_group_id = module.security.vpc_endpoint_security_group_id
  vpc_flow_log_settings = merge(
    var.vpc_flow_log_settings,
    {
      log_destination = module.monitoring.vpc_flow_log_cloudwatch_log_group_name
    }
  )
}

module "security" {
  source            = "../../modules/security"
  vpc_id            = module.networking.vpc_id
  project_settings  = var.project_settings
  alb_ingress_rules = var.alb_ingress_rules
  security_groups   = var.security_groups
  sg_flows          = var.sg_flows
  s3_prefix_list_id = module.networking.s3_gateway_vpc_endpoint_id
  kms_keys          = var.kms_keys
  key_role_arns     = {}
}

module "monitoring" {
  source                             = "../../modules/monitoring"
  project_settings                   = var.project_settings
  vpc_flow_logs_cloudwatch_log_group = var.vpc_flow_logs_cloudwatch_log_group
  cloudwatch_log_groups              = var.cloudwatch_log_groups
  kms_key_arn                        = module.security.keys_arns["cloudwatch_logs"]
  alert_email                        = var.alert_email
  ecs_running_task_alarms            = var.ecs_running_task_alarms
  cluster_name                       = var.cluster_name
  ecs_service_names                  = var.ecs_service_names
  dlq_alarm                          = var.dlq_alarm
  dlq_name                           = var.dlq_name
  rds_alarm                          = var.rds_alarm
  db_instance_identifier             = var.db_instance_identifier
}
