resource "aws_route53_zone" "this" {
  name = "${var.project_settings.project_name}.sehindemi.com"

}
