module "networking" {
  source                         = "../../modules/networking"
  vpc_settings                   = var.vpc_settings
  subnet_settings                = var.subnet_settings
  project_settings               = var.project_settings
  interface_endpoints            = var.interface_endpoints
  vpc_endpoint_security_group_id = module.security.vpc_endpoint_security_group_id

}

module "security" {
  source            = "../../modules/security"
  vpc_id            = module.networking.vpc_id
  project_settings  = var.project_settings
  alb_ingress_rules = var.alb_ingress_rules
  security_groups   = var.security_groups
  sg_flows          = var.sg_flows
  s3_prefix_list_id = module.networking.s3_gateway_vpc_endpoint_id
}
