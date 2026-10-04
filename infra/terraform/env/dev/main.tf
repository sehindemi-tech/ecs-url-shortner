module "networking" {
  source           = "../../modules/networking"
  vpc_settings     = var.vpc_settings
  subnet_settings  = var.subnet_settings
  project_settings = var.project_settings


}
