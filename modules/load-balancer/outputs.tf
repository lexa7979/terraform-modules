output "target_group_arn" {
  description = "ARN of the target group which is responsible to health-check the related services"
  value = aws_lb_target_group.module.arn
}

output "dns_name" {
  description = "The domain name of the load balancer"
  value = aws_lb.module.dns_name
}
