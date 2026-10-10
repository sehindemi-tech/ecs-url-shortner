resource "aws_security_group" "this" {
  for_each = var.security_groups

  name        = "${var.project_settings.project_name}-${each.key}"
  description = each.value.description
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.project_settings.project_name}-${each.key}"
  }
  lifecycle {
    create_before_destroy = true
  }
}

output "vpc_endpoint_security_group_id" {
  description = "The security group ID associated with interface VPC endpoints"
  value       = aws_security_group.this["vpc_endpoints"].id
}

resource "aws_vpc_security_group_ingress_rule" "internet_to_alb" {
  for_each = var.alb_ingress_rules

  security_group_id = aws_security_group.this["alb"].id
  cidr_ipv4         = each.value.cidr_ipv4
  description       = each.value.description
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  ip_protocol       = each.value.ip_protocol
}

resource "aws_vpc_security_group_ingress_rule" "flow" {
  for_each = var.sg_flows

  security_group_id            = aws_security_group.this[each.value.to].id
  referenced_security_group_id = aws_security_group.this[each.value.from].id
  description                  = "${each.value.from} to ${each.value.to}"
  from_port                    = each.value.port
  to_port                      = each.value.port
  ip_protocol                  = "tcp"
}




resource "aws_vpc_security_group_egress_rule" "flow" {
  for_each = var.sg_flows

  security_group_id            = aws_security_group.this[each.value.from].id
  referenced_security_group_id = aws_security_group.this[each.value.to].id
  description                  = "${each.value.from} to ${each.value.to}"
  from_port                    = each.value.port
  to_port                      = each.value.port
  ip_protocol                  = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "tasks_to_s3" {
  for_each = { for name, sg in var.security_groups : name => sg if sg.s3_egress }

  security_group_id = aws_security_group.this[each.key].id
  prefix_list_id    = var.s3_prefix_list_id
  ip_protocol       = "tcp"
  from_port         = 443
  to_port           = 443
  description       = "${each.key} to S3 gateway endpoint"
}
