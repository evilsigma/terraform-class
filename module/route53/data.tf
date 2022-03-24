
data "aws_vpc" "this" {

    tags = {
        Name = "vpc-ue1-${var.proy}-${var.env}-01"
    }
} 


data "aws_subnet" "subnet_publica2" {

    tags = {
        Name = "sn-ue1-${var.proy}-${var.env}-public02"
    }
}

data "aws_subnet" "subnet_publica" {
    tags = {
        Name = "sn-ue1-${var.proy}-${var.env}-public01"
    }
}


data "aws_lb" "this" {
  name = "alb-ue1-${var.proy}-${var.env}-01"
}