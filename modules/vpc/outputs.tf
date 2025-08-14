output "vpc_cidr" {
  value = aws_vpc.counter_service_vpc.cidr_block
}

output "vpc_id" {
  value = aws_vpc.counter_service_vpc.id
}

output "public_subnet_ids" {
  value = [for s in aws_subnet.counter_service_public_subnets : s.id]
}

output "private_subnet_ids" {
  value = [for s in aws_subnet.counter_service_private_subnets : s.id]
}