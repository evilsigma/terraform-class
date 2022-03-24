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


resource "aws_route53_record" "web" {
  zone_id = aws_route53_zone.private.zone_id
  name    = var.dns_name
  type    = "A"

  alias {
    name                   = data.aws_lb.this.dns_name
    zone_id                = data.aws_lb.this.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "web.${var.dns_name}"
  type    = "A"
  ttl     = "300"
  records = ["172.18.0.227"]
}