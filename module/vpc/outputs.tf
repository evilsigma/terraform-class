//vamos a definir las salidas de nuestra plantilla
output "subnet_id_nat" {
    value = aws_subnet.sn_public02.id
}

output "rt_private_01" {
    value = aws_route_table.rt_private01.id
}

output "rt_private_02" {
    value = aws_route_table.rt_private02.id
}