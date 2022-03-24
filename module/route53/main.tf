resource "aws_route53_zone" "private" {
  name = var.dns_name

  vpc {
    vpc_id = data.aws_vpc.this.id
  }
  
  tags = {
    Ambiente = var.env
    Proyecto = var.proy
  }
}