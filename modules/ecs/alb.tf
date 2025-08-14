resource "aws_security_group" "load_balancer_sg" {
  name = "${var.cluster_name}-alb-sg"
  description = "Security group for load balancer"
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.cluster_name}-alb-sg"
  }
  ingress {
    description = "HTTP from anywhere"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "ecs_cluster_sg" {
  name = "${var.cluster_name}-ecs-sg"
  description = "ECS service sg"
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.cluster_name}-ecs-sg"
  }

  ingress {
    description = "Traffic from load balancer"
    from_port = var.container_port
    to_port = var.container_port
    protocol = "tcp"
    security_groups = [aws_security_group.load_balancer_sg.id]
  }

  egress {
    description = "All traffic is allowed"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb" "application_load_balancer" {
  name = "${var.cluster_name}-alb"
  load_balancer_type = "application"
  security_groups = [aws_security_group.load_balancer_sg.id]
  subnets = var.public_subnet_ids
  tags = {
    Name = "${var.cluster_name}-alb"
  }
}

resource "aws_lb_target_group" "application_target_group" {
  name = "${var.cluster_name}-tg"
  port = var.container_port
  protocol = "HTTP"
  target_type = "ip"
  vpc_id = var.vpc_id

  health_check {
    path = var.health_check_path
    healthy_threshold = 2
  }

  tags = {
    Name = "${var.cluster_name}-tg"
  }
}

resource "aws_lb_listener" "application_listener_http" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.application_target_group.arn
  }
}