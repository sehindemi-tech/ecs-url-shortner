resource "aws_route53_zone" "this" {
  name = "${var.project_settings.project_name}.sehindemi.com"

}


resource "aws_route53_record" "alb_alias" {
  for_each = var.records

  zone_id = aws_route53_zone.this.zone_id
  name    = each.value.name
  type    = each.value.type

  alias {
    name                   = var.alb_settings.dns_name
    zone_id                = var.alb_settings.zone_id
    evaluate_target_health = true
  }

}
