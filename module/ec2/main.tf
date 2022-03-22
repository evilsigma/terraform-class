/*
resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon-2.id
  instance_type = var.instance_type
  key_name = data.aws_key_pair.this.key_name

  network_interface {
    network_interface_id = aws_network_interface.this.id
    device_index         = 0
  }

   tags = {
    Name = "ec2-ue1-${var.proy}-${var.env}-01"
    Ambiente = var.env
    Proyecto = var.proy
  }
}

resource "aws_network_interface" "this" {
  subnet_id   = data.aws_subnet.subnet_privada.id

  tags = {
    Name = "eni-ue1-${var.proy}-${var.env}-01"
    Ambiente = var.env
    Proyecto = var.proy
  }
} 

*/
resource "aws_network_interface" "eni02" {
  subnet_id   = data.aws_subnet.subnet_publica.id
  security_groups = [aws_security_group.sg_bastion.id]
  tags = {
    Name = "eni-ue1-${var.proy}-${var.env}-02"
    Ambiente = var.env
    Proyecto = var.proy
  }
} 


resource "aws_instance" "bastion" {
  ami           = data.aws_ami.amazon-2.id
  instance_type = var.instance_type
  key_name = data.aws_key_pair.this.key_name
  network_interface {
    network_interface_id = aws_network_interface.eni02.id
    device_index         = 0
  }

   tags = {
    Name = "ec2-ue1-${var.proy}-${var.env}-02"
    Ambiente = var.env
    Proyecto = var.proy
  }
}

resource "aws_security_group" "sg_bastion" {
  name        = "SG-ue1-${var.proy}-${var.env}-01"
  description = "grupo de seguridad para instancia bastion"
  vpc_id      = data.aws_vpc.this.id

  ingress {
    description      = "SHH desde VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [data.aws_vpc.this.cidr_block]
  }

  ingress {
    description      = "SHH desde Internet"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

 ingress {
    description      = "80 desde VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [data.aws_vpc.this.cidr_block]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "ec2-ue1-${var.proy}-${var.env}-02"
    Ambiente = var.env
    Proyecto = var.proy
  }
}