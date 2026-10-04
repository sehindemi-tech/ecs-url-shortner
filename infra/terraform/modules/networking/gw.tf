resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.url_shortner.id

  tags = {
    Name = "${var.project_settings.project_name}-igw"
  }
}
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.ngw.id
  subnet_id     = aws_subnet.public_subnets["Public_Subnets_1"].id

  tags = {
    Name = "${var.project_settings.project_name}-ngw"
  }
}

resource "aws_eip" "ngw" {
  domain = "vpc"

  tags = {
    Name = "${var.project_settings.project_name}-ngw-eip"
  }
}
