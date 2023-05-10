output "vpc_id" {
  value       = aws_vpc.vpc.id
  description = "VPC ID"
}

output "PrivateSubnet" {
  value       = values(aws_subnet.private)[*].id
  description = "Private Subnets ID"
}