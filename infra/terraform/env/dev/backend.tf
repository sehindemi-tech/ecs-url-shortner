terraform {
  backend "s3" {
    bucket       = "terraform-state-441336784821"
    key          = "terraform.tfstate"
    region       = "eu-west-2"
    use_lockfile = true
  }
}
