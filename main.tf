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