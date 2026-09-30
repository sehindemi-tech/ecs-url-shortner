module "networking" {
  source       = "../../modules/networking"
  vpc_settings = var.vpc_settings
}
