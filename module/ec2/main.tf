resource "aws_instance" "web" {
  ami           = data.aws_ami_ids.ubuntu.id
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
    Name = "primary_network_interface"
  }
} 