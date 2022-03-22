resource "aws_lb" "this" {
  name               = "nlb-ue1-${var.proy}-${var.env}-01"
  internal           = false
  load_balancer_type = "network"
  subnets            = [data.aws_subnet.subnet_publica.id,data.aws_subnet.subnet_publica2.id]

  enable_deletion_protection = true

  tags = {
    Name = "nlb-ue1-${var.proy}-${var.env}-02"
    Ambiente = var.env
    Proyecto = var.proy
  }
}


resource "aws_lb_listener" "web" {
  load_balancer_arn = aws_lb.this.arn
  port              = "80"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

resource "aws_lb_target_group" "this" {
  name     = "tg-ue1-${var.proy}-${var.env}-01"
  port     = 80
  protocol = "TCP"
  vpc_id   = data.aws_vpc.this.id
  deregistration_delay = 30

  tags = {
    Name = "tg-ue1-${var.proy}-${var.env}-02"
    Ambiente = var.env
    Proyecto = var.proy
  }
}

resource "aws_lb_target_group_attachment" "this" {
  target_group_arn = aws_lb_target_group.this.arn
  target_id        = var.instance_id
  port             = 80
}

