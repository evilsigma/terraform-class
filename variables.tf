//definiremos las variables de entrada de nuestro terraform
variable "cidr" {
  type = string
  default = "172.18.0.0/16"
}

variable "env" {
  type = string
  default = "dev"
}

variable "proy" {
  type = string
  default = "chatbot"
}

variable "cidr_public01" {
  type = string
  default = "172.18.0.0/24"
}

variable "cidr_public02" {
  type = string
  default = "172.18.2.0/24"
}


variable "cidr_private01" {
  type = string
  default = "172.18.3.0/24"
}

variable "cidr_private02" {
  type = string
  default = "172.18.4.0/24"
}