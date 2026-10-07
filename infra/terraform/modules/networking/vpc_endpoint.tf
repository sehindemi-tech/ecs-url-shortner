resource "aws_vpc_endpoint" "gateway" {
  vpc_id            = aws_vpc.url_shortner.id
  route_table_ids   = [aws_route_table.private.id]
  vpc_endpoint_type = "Gateway"
  service_name      = "com.amazonaws.eu-west-2.s3"
}

resource "aws_vpc_endpoint" "interface" {
  for_each = toset(var.interface_endpoints)

  vpc_id              = aws_vpc.url_shortner.id
  service_name        = "com.amazonaws.eu-west-2.${each.key}"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [for k, v in aws_subnet.private_subnets : v.id]
  security_group_ids  = [var.vpc_endpoint_security_group_id]
  private_dns_enabled = true
}
