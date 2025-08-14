resource "aws_vpc" "counter_service_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.global_name}-vpc"
  }
}

resource "aws_subnet" "counter_service_public_subnets" {
  vpc_id = aws_vpc.counter_service_vpc.id
  count = length(var.public_subnet_cidrs)
  availability_zone = var.availability_zones[count.index]
  cidr_block = var.public_subnet_cidrs[count.index]
  tags = {
    Name = "${var.global_name}-public-subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "counter_service_private_subnets" {
  vpc_id = aws_vpc.counter_service_vpc.id
  count = length(var.private_subnet_cidrs)
  availability_zone = var.availability_zones[count.index]
  cidr_block = var.private_subnet_cidrs[count.index]
  tags = {
    Name = "${var.global_name}-private-subnet-${count.index + 1}"
  }
}

resource "aws_route_table" "counter_service_public_rt" {
  vpc_id = aws_vpc.counter_service_vpc.id
  tags = {
    Name = "${var.global_name}-public-rt"
  }
}

resource "aws_route_table" "counter_service_private_rt" {
  vpc_id = aws_vpc.counter_service_vpc.id
  tags = {
    Name = "${var.global_name}.private-rt"
  }
}

resource "aws_route_table_association" "counter_service_public_rt_association" {
  count = length(var.public_subnet_cidrs)
  subnet_id = aws_subnet.counter_service_public_subnets[count.index].id
  route_table_id = aws_route_table.counter_service_public_rt.id
}

resource "aws_route_table_association" "counter_service_private_rt_associatoin" {
  count = length(var.private_subnet_cidrs)
  subnet_id = aws_subnet.counter_service_private_subnets[count.index].id
  route_table_id = aws_route_table.counter_service_private_rt.id
}

resource "aws_internet_gateway" "counter_service_igw" {
  vpc_id = aws_vpc.counter_service_vpc.id
  tags = {
    Name = "${var.global_name}-igw"
  }
}

resource "aws_route" "counter_service_internet_route" {
  route_table_id = aws_route_table.counter_service_public_rt.id
  gateway_id = aws_internet_gateway.counter_service_igw.id
  destination_cidr_block = "0.0.0.0/0"
}

