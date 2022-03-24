data "aws_ami" "amazon-2" {
  most_recent = true

  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
  owners = ["amazon"]
}

data "aws_vpc" "this" {

    tags = {
        Name = "vpc-ue1-${var.proy}-${var.env}-01"
    }
}


data "aws_subnet" "subnet_privada" {

    tags = {
        Name = "sn-ue1-${var.proy}-${var.env}-private01"
    }
}

data "aws_subnet" "subnet_publica" {
    tags = {
        Name = "sn-ue1-${var.proy}-${var.env}-public01"
    }
}

data "aws_key_pair" "this" {
  key_name = "kp-ue1-${var.proy}-${var.env}-03"
}