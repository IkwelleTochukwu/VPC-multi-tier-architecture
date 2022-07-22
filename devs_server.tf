resource "aws_instance" "Public-server-1" {
  ami           = var.server-ami-devs
  instance_type = var.instance-type-devs
  key_name      = var.keyname_server

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.ENI-dev-server.id
  }

  root_block_device {
    volume_size           = var.rootvolumesize-devs
    volume_type           = "gp2"
    delete_on_termination = true

    tags = var.resource-tags-vpc-1
  }

  tags = var.resource-tags-vpc-1

}



resource "aws_instance" "Private-server-1a" {
  ami                         = var.server-ami-devs
  instance_type               = var.instance-type-devs
  key_name                    = var.keyname_server
  associate_public_ip_address = false
  subnet_id                   = aws_subnet.private_sub-vpc-1a.id
  vpc_security_group_ids      = [aws_security_group.Security-vpc-1.id]


  root_block_device {
    volume_size           = var.rootvolumesize-devs
    volume_type           = "gp2"
    delete_on_termination = true

    tags = var.resource-tags-vpc-1
  }

  tags = var.resource-tags-vpc-1
}



resource "aws_instance" "Private-server-1b" {
  ami                         = var.server-ami-devs
  instance_type               = var.instance-type-devs
  key_name                    = var.keyname_server
  associate_public_ip_address = false
  subnet_id                   = aws_subnet.private_sub-vpc-1b.id
  vpc_security_group_ids      = [aws_security_group.Security-vpc-1.id]


  root_block_device {
    volume_size           = var.rootvolumesize-devs
    volume_type           = "gp2"
    delete_on_termination = true

    tags = var.resource-tags-vpc-1
  }

  tags = var.resource-tags-vpc-1
}



resource "aws_instance" "Private-server-1c" {
  ami                         = var.server-ami-devs
  instance_type               = var.instance-type-devs
  key_name                    = var.keyname_server
  associate_public_ip_address = false
  subnet_id                   = aws_subnet.private_sub-vpc-1a.id
  vpc_security_group_ids      = [aws_security_group.Security-vpc-1.id]


  root_block_device {
    volume_size           = var.rootvolumesize-devs
    volume_type           = "gp2"
    delete_on_termination = true

    tags = var.resource-tags-vpc-1
  }

  tags = var.resource-tags-vpc-1
}