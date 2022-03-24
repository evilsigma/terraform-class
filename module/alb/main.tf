resource "aws_lb" "this" {
  name               = "alb-ue1-${var.proy}-${var.env}-01"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [data.aws_subnet.subnet_publica.id, data.aws_subnet.subnet_publica2.id]


   tags = {
    Name = "ec2-ue1-${var.proy}-${var.env}-03"
    Ambiente = var.env
    Proyecto = var.proy
  }
}


resource "aws_security_group" "lb_sg" {
  name        = "SG-ue1-${var.proy}-${var.env}-alb-01"
  description = "Allow TLS inbound traffic"
  vpc_id      = data.aws_vpc.this.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "HTTP from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

   tags = {
    Name = "ec2-ue1-${var.proy}-${var.env}-03"
    Ambiente = var.env
    Proyecto = var.proy
  }
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

resource "aws_lb_target_group" "this" {
  name     = "tg-ue1-${var.proy}-${var.env}-01"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.this.id
  deregistration_delay = 30
  tags = {
    Name = "tg-ue1-${var.proy}-${var.env}-02"
    Ambiente = var.env
    Proyecto = var.proy
  }
}


