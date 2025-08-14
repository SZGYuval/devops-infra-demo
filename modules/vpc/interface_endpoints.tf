resource "aws_security_group" "vpce_sg" {
  name = "${var.global_name}-vpce-sg"
  description = "Allow HTTPS from vpc to vpc interface endpoints"
  vpc_id = aws_vpc.counter_service_vpc.id

  ingress {
    description = "HTTPS from  vpc"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_vpc_endpoint" "ecr_api_endpoint" {
  vpc_id = aws_vpc.counter_service_vpc.id
  service_name = "com.amazonaws.${var.aws_region}.ecr.api"
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true
  subnet_ids = [for subnet in aws_subnet.counter_service_private_subnets : subnet.id]
  security_group_ids = [aws_security_group.vpce_sg.id]
  tags = {
    Name = "${var.global_name}-vpce-ecr-api"
  }
}

resource "aws_vpc_endpoint" "ecr_dkr_endpoint" {
  vpc_id = aws_vpc.counter_service_vpc.id
  service_name = "com.amazonaws.${var.aws_region}.ecr.dkr"
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true
  subnet_ids = [for subnet in aws_subnet.counter_service_private_subnets : subnet.id]
  security_group_ids = [aws_security_group.vpce_sg.id]
  tags = {
    Name = "${var.global_name}-vpce-ecr-dkr"
  }
}

resource "aws_vpc_endpoint" "cloudwatch_logs_endpoint" {
  vpc_id = aws_vpc.counter_service_vpc.id
  service_name = "com.amazonaws.${var.aws_region}.logs"
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true
  subnet_ids = [for subnet in aws_subnet.counter_service_private_subnets : subnet.id]
  security_group_ids = [aws_security_group.vpce_sg.id]
  tags = {
    Name = "${var.global_name}-vpce-logs"
  }
}

resource "aws_vpc_endpoint" "s3_gateway_endpoint" {
  vpc_id = aws_vpc.counter_service_vpc.id
  service_name = "com.amazonaws.${var.aws_region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids = [aws_route_table.counter_service_private_rt.id]
  tags = {
    Name = "${var.global_name}-vpce-s3"
  }
}
