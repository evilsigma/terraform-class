
resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id
  subnet_id     = var.subnet_id

  tags = {
    Name = "ngw-ue1-${var.proy}-${var.env}-01"
    Ambiente = var.env
    Proyecto = var.proy
  }
}

resource "aws_eip" "this" {
  tags = {
    Name = "ngw-ue1-${var.proy}-${var.env}-01"
    Ambiente = var.env
    Proyecto = var.proy
  }
}

resource "aws_route" "subnet_privada01" {
  route_table_id            = var.rt_private01
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id            = aws_nat_gateway.this.id
}

resource "aws_route" "subnet_privada02" {
  route_table_id            = var.rt_private02
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id            = aws_nat_gateway.this.id
}