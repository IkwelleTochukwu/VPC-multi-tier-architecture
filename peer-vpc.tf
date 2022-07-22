resource "aws_vpc_peering_connection" "VPC-1-and-VPC-2-peering" {
  peer_vpc_id = aws_vpc.VPC-2.id
  vpc_id      = aws_vpc.VPC-1.id
  auto_accept = true

  tags = {
    Name = "VPC Peering between devs-network and prods-network"
  }
}

# modify routes for the vpc-peering connection in both the route tables for pub-rtb-vpc-1
# and priv-rtb-vpc-2

resource "aws_route" "pub-vpc-1-rtb" {
  route_table_id            = aws_route_table.vpc-1-pub-rtb.id
  destination_cidr_block    = "20.20.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.VPC-1-and-VPC-2-peering.id
}


resource "aws_route" "priv-vpc-2-rtb" {
  route_table_id            = aws_route_table.vpc-2-priv-rtb.id
  destination_cidr_block    = "20.10.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.VPC-1-and-VPC-2-peering.id
}
