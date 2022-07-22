This is a terraform module for a VPC multi-tier architecture with 2 vpcs; vpc-1 and vpc-2, having 
4 subnets (1 public and 3 private) and 2 subnets (1 public and 1 private) respectively, with ec2 
instances in each.
The public subnets are supported with the NAT gateways to allow internet access from the servers in 
the private subnets through the servers in the public subnets.
A vpc peering connection is established between the vpc-1 and vpc-2 through the public route table in
vpc-1 and the private route table in vpc-2.