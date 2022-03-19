
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