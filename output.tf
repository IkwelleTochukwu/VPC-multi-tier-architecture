output "aws_instance-publicserver1-pub_ip-address" {
  description = "public ip address of the public server in vpc-1"
  value       = aws_instance.Public-server-1.public_ip
}

output "aws_instance-privateserver1a-priv_ip-address" {
  description = "private ip address of the first private server in vpc-1"
  value       = aws_instance.Private-server-1a.private_ip
}

output "aws_instance-privateserver1b-priv_ip-address" {
  description = "private ip address of the second private server in vpc-1"
  value       = aws_instance.Private-server-1b.private_ip
}

output "aws_instance-privateserver1c-priv-ip-address" {
  description = "private ip address of the third private server in the vpc-1"
  value       = aws_instance.Private-server-1c.private_ip

}

output "aws_instance-publicserver2-pub-ip-address" {
  description = "public ip address of the public server in the vpc-2"
  value       = aws_instance.Public-server-2.public_ip
}

output "aws_instance-privateserver2a-priv-ip-address" {
  description = "private ip address of the private server in the vpc-2"
  value       = aws_instance.Private-server-2a.private_ip
}

