resource "random_password" "auth" {
  length      = 32
  lower       = true
  min_lower   = 5
  min_numeric = 5
  special     = false
}
