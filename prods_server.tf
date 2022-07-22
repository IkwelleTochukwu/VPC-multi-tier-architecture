resource "aws_instance" "Public-server-2" {
  ami           = var.server-ami-prods
  instance_type = var.instance-type-prods
  key_name      = var.keyname_server

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.ENI-prods-server.id
  }

  root_block_device {
    volume_size           = var.rootvolumesize-prods
    volume_type           = "gp2"
    delete_on_termination = true

    tags = var.resource-tags-vpc-2
  }

  tags = var.resource-tags-vpc-2

}


resource "aws_instance" "Private-server-2a" {
  ami                         = var.server-ami-prods
  instance_type               = var.instance-type-prods
  key_name                    = var.keyname_server
  associate_public_ip_address = false
  subnet_id                   = aws_subnet.private_sub-vpc-2.id
  vpc_security_group_ids      = [aws_security_group.Security-vpc-2.id]


  root_block_device {
    volume_size           = var.rootvolumesize-prods
    volume_type           = "gp2"
    delete_on_termination = true

    tags = var.resource-tags-vpc-2
  }

  tags = var.resource-tags-vpc-2
}
