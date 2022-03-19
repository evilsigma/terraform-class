data "aws_ami_ids" "ubuntu" {
  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/ubuntu-*-*-amd64-server-*"]
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
  key_name = "kp-ue1-${var.proy}-${var.env}-02"
}