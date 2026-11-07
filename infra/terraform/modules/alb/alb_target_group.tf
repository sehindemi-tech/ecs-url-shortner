resource "aws_lb_target_group" "this" {
  for_each = var.target_groups

  name                              = "${var.target_group_name_prefix}-${each.key}"
  port                              = each.value.port
  protocol                          = each.value.protocol
  target_type                       = each.value.target_type
  vpc_id                            = var.vpc_id
  ip_address_type                   = each.value.ip_address_type
  load_balancing_algorithm_type     = each.value.load_balancing_algorithm_type
  load_balancing_cross_zone_enabled = true
  deregistration_delay              = each.value.deregistration_delay
  health_check {
    enabled             = true
    healthy_threshold   = var.health_check.healthy_threshold
    unhealthy_threshold = var.health_check.unhealthy_threshold
    interval            = var.health_check.interval
    matcher             = var.health_check.matcher
    timeout             = var.health_check.timeout
    path                = var.health_check.path
    port                = var.health_check.port
    protocol            = var.health_check.protocol
  }
}
