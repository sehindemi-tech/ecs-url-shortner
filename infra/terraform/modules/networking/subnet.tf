resource "aws_subnet" "public_subnets" {
  for_each                = { for key, value in var.subnet_settings : key => value if value.is_public }
  vpc_id                  = aws_vpc.url_shortner.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = each.value.map_public_ip_on_launch

  tags = {
    Name = each.key
    Tier = "Public"
  }
}

resource "aws_subnet" "private_subnets" {
  for_each                = { for key, value in var.subnet_settings : key => value if !value.is_public }
  vpc_id                  = aws_vpc.url_shortner.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = each.value.map_public_ip_on_launch

  tags = {
    Name = each.key
    Tier = "Private"
  }
}
