terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

# configure aws provider

provider "aws" {
  region  = var.aws_region
  profile = "default"
}

# create development vpc-1

resource "aws_vpc" "VPC-1" {
  cidr_block           = var.cidrblock-vpc-1
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = var.resource-tags-vpc-1
}

# create public subnet for vpc-1

resource "aws_subnet" "public_sub-vpc-1" {
  vpc_id                  = aws_vpc.VPC-1.id
  cidr_block              = var.cidrblock-vpc-1-pub
  availability_zone       = "us-west-1a"
  map_public_ip_on_launch = true

  tags = var.resource-tags-vpc-1
}

# create private subnets for vpc-1

resource "aws_subnet" "private_sub-vpc-1a" {
  vpc_id                  = aws_vpc.VPC-1.id
  cidr_block              = var.cidr_block-vpc-1-priv-1a
  availability_zone       = "us-west-1a"
  map_public_ip_on_launch = false

  tags = var.resource-tags-vpc-1
}

resource "aws_subnet" "private_sub-vpc-1b" {
  vpc_id                  = aws_vpc.VPC-1.id
  cidr_block              = var.cidr_block-vpc-1-priv-1b
  availability_zone       = "us-west-1c"
  map_public_ip_on_launch = false

  tags = var.resource-tags-vpc-1
}

resource "aws_subnet" "private_sub-vpc-1c" {
  vpc_id                  = aws_vpc.VPC-1.id
  cidr_block              = var.cidr_block-vpc-1-priv-1c
  availability_zone       = "us-west-1a"
  map_public_ip_on_launch = false

  tags = var.resource-tags-vpc-1
}

# create internet gateway for vpc-1

resource "aws_internet_gateway" "vpc-1-igw" {
  vpc_id = aws_vpc.VPC-1.id

  tags = var.resource-tags-vpc-1

}

# create a public route table for vpc-1

resource "aws_route_table" "vpc-1-pub-rtb" {
  vpc_id = aws_vpc.VPC-1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc-1-igw.id
  }

  tags = var.resource-tags-vpc-1
}

resource "aws_route_table_association" "vpc-1-pub-rtb-asso" {
  subnet_id      = aws_subnet.public_sub-vpc-1.id
  route_table_id = aws_route_table.vpc-1-pub-rtb.id
}

# create a private route table for vpc-1

resource "aws_route_table" "vpc-1-priv-rtb" {
  vpc_id = aws_vpc.VPC-1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.pub-nat_gw-vpc-1.id
  }

  tags = var.resource-tags-vpc-1
}

resource "aws_route_table_association" "vpc-1-privA-rtb-asso" {
  subnet_id      = aws_subnet.private_sub-vpc-1a.id
  route_table_id = aws_route_table.vpc-1-priv-rtb.id
}

resource "aws_route_table_association" "vpc-1-privB-rtb-asso" {
  subnet_id      = aws_subnet.private_sub-vpc-1b.id
  route_table_id = aws_route_table.vpc-1-priv-rtb.id
}

resource "aws_route_table_association" "vpc-1-privC-rtb-asso" {
  subnet_id      = aws_subnet.private_sub-vpc-1c.id
  route_table_id = aws_route_table.vpc-1-priv-rtb.id
}


# create NAT gateway for public subnet in vpc-1

resource "aws_eip" "NAT-eip" {
  vpc = true

  depends_on = [
    aws_internet_gateway.vpc-1-igw
  ]
}

resource "aws_nat_gateway" "pub-nat_gw-vpc-1" {
  allocation_id = aws_eip.NAT-eip.id
  subnet_id     = aws_subnet.public_sub-vpc-1.id

  tags = var.resource-tags-vpc-1
}

# create security group for vpc-1

resource "aws_security_group" "Security-vpc-1" {
  name        = "SG-vpc-1"
  description = "Allow internet traffic"
  vpc_id      = aws_vpc.VPC-1.id

  ingress {
    description = "allow ssh on port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow http on port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.resource-tags-vpc-1
}

# create network interface for public server-vpc-1

resource "aws_network_interface" "ENI-dev-server" {
  subnet_id       = aws_subnet.public_sub-vpc-1.id
  security_groups = [aws_security_group.Security-vpc-1.id]
}

/*create key pair for instance

resource "aws_key_pair" "projectkey" {
  key_name   = var.keyname_server
  public_key = var.publickey-A
}*/

#
#
# create production vpc-2

resource "aws_vpc" "VPC-2" {
  cidr_block           = var.cidrblock-vpc-2
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = var.resource-tags-vpc-2
}

# create public subnet for vpc-2

resource "aws_subnet" "public_sub-vpc-2" {
  vpc_id                  = aws_vpc.VPC-2.id
  cidr_block              = var.cidrblock-vpc-2-pub
  availability_zone       = "us-west-1a"
  map_public_ip_on_launch = true

  tags = var.resource-tags-vpc-2
}

# create private subnet for vpc-2

resource "aws_subnet" "private_sub-vpc-2" {
  vpc_id                  = aws_vpc.VPC-2.id
  cidr_block              = var.cidr_block-vpc-2-priv
  availability_zone       = "us-west-1c"
  map_public_ip_on_launch = false

  tags = var.resource-tags-vpc-2
}

# create internet gateway for vpc-2

resource "aws_internet_gateway" "vpc-2-igw" {
  vpc_id = aws_vpc.VPC-2.id

  tags = var.resource-tags-vpc-2

}

# create a  public route table for vpc-2

resource "aws_route_table" "vpc-2-pub-rtb" {
  vpc_id = aws_vpc.VPC-2.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc-2-igw.id
  }

  tags = var.resource-tags-vpc-2
}

resource "aws_route_table_association" "vpc-2-pub-rtb-asso" {
  subnet_id      = aws_subnet.public_sub-vpc-2.id
  route_table_id = aws_route_table.vpc-2-pub-rtb.id
}


# create a private route table for vpc-2

resource "aws_route_table" "vpc-2-priv-rtb" {
  vpc_id = aws_vpc.VPC-2.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.pub-nat_gw-vpc-2.id
  }

  tags = var.resource-tags-vpc-2
}

resource "aws_route_table_association" "vpc-2-priv-rtb-asso" {
  subnet_id      = aws_subnet.private_sub-vpc-2.id
  route_table_id = aws_route_table.vpc-2-priv-rtb.id
}


# create NAT gateway for public subnet in vpc-2

resource "aws_eip" "NAT-eip-2" {
  vpc = true

  depends_on = [
    aws_internet_gateway.vpc-2-igw
  ]
}

resource "aws_nat_gateway" "pub-nat_gw-vpc-2" {
  allocation_id = aws_eip.NAT-eip-2.id
  subnet_id     = aws_subnet.public_sub-vpc-2.id

  tags = var.resource-tags-vpc-2
}

# create security group for vpc-2

resource "aws_security_group" "Security-vpc-2" {
  name        = "SG-vpc-2"
  description = "Allow internet traffic"
  vpc_id      = aws_vpc.VPC-2.id

  ingress {
    description = "allow ssh on port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow http on port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.resource-tags-vpc-2
}

# create network interface for public server-vpc-2

resource "aws_network_interface" "ENI-prods-server" {
  subnet_id       = aws_subnet.public_sub-vpc-2.id
  security_groups = [aws_security_group.Security-vpc-2.id]
}
