//aqui se definira la estructura principal de la plantilla de terraform
resource "aws_vpc" "this" {
  cidr_block       = var.cidr
  enable_dns_hostnames = true
  tags = {
    Name = "vpc-ue1-${var.proy}-${var.env}-01"
    Ambiente = var.env
    Proyecto = var.proy
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "igw-ue1-${var.proy}-${var.env}-01"
    Ambiente = var.env
    Proyecto = var.proy
  }
}


resource "aws_route_table" "rt_public01" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = "rt-ue1-${var.proy}-${var.env}-public01"
    Ambiente = var.env
    Proyecto = var.proy
  }
}



resource "aws_route_table" "rt_public02" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = "rt-ue1-${var.proy}-${var.env}-public02"
    Ambiente = var.env
    Proyecto = var.proy
  }
}

resource "aws_route_table" "rt_private01" {
  vpc_id = aws_vpc.this.id


  tags = {
    Name = "rt-ue1-${var.proy}-${var.env}-private01"
    Ambiente = var.env
    Proyecto = var.proy
  }
}

resource "aws_route_table" "rt_private02" {
  vpc_id = aws_vpc.this.id


  tags = {
    Name = "rt-ue1-${var.proy}-${var.env}-private02"
    Ambiente = var.env
    Proyecto = var.proy
  }
}


resource "aws_subnet" "sn_public01" {
  vpc_id     = aws_vpc.this.id
  cidr_block = var.cidr_public01
  map_public_ip_on_launch = true

  tags = {
    Name = "sn-ue1-${var.proy}-${var.env}-public01"
    Ambiente = var.env
    Proyecto = var.proy
  }
}

resource "aws_route_table_association" "as_public01" {
  subnet_id      = aws_subnet.sn_public01.id
  route_table_id = aws_route_table.rt_public01.id
}

resource "aws_subnet" "sn_public02" {
  vpc_id     = aws_vpc.this.id
  cidr_block = var.cidr_public02
  map_public_ip_on_launch = true

  tags = {
    Name = "sn-ue1-${var.proy}-${var.env}-public02"
    Ambiente = var.env
    Proyecto = var.proy
  }
}

resource "aws_route_table_association" "as_public02" {
  subnet_id      = aws_subnet.sn_public02.id
  route_table_id = aws_route_table.rt_public02.id
}

resource "aws_subnet" "sn_private01" {
  vpc_id     = aws_vpc.this.id
  cidr_block = var.cidr_private01

  tags = {
    Name = "sn-ue1-${var.proy}-${var.env}-private01"
    Ambiente = var.env
    Proyecto = var.proy
  }
}

resource "aws_route_table_association" "as_private01" {
  subnet_id      = aws_subnet.sn_private01.id
  route_table_id = aws_route_table.rt_private01.id
}

resource "aws_subnet" "sn_private02" {
  vpc_id     = aws_vpc.this.id
  cidr_block = var.cidr_private02

  tags = {
    Name = "sn-ue1-${var.proy}-${var.env}-private02"
    Ambiente = var.env
    Proyecto = var.proy
  }
}

resource "aws_route_table_association" "as_private02" {
  subnet_id      = aws_subnet.sn_private02.id
  route_table_id = aws_route_table.rt_private02.id
}

