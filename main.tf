//aqui se definira la estructura principal de la plantilla de terraform
module "vpc" {
  source = "./module/vpc"
  cidr = var.cidr
  env = var.env
  proy = var.proy
  cidr_public01 = var.cidr_public01
  cidr_public02 = var.cidr_public02
  cidr_private01 = var.cidr_private01
  cidr_private02 = var.cidr_private02
}

module "natgateway" {
  source = "./module/natgateway"
  subnet_id = module.vpc.subnet_id_nat
  proy = var.proy
  env = var.env
  rt_private01 = module.vpc.rt_private_01
  rt_private02 = module.vpc.rt_private_02
}

module "ec2" {
  source = "./module/ec2"
  proy = var.proy
  env = var.env
  instance_type = "t2.micro"
}



module "nlb" {
  source = "./module/nlb"
  proy = var.proy
  env = var.env
  instance_id = module.ec2.instance_id
}

