output "alb_dns_name"  { 
    value = aws_lb.application_load_balancer.dns_name
}

output "cluster_name"  { 
    value = aws_ecs_cluster.ecs_cluster.name
}
