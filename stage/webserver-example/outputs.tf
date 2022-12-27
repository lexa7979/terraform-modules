output "alb_dns_name" {
  description = "The domain name of the load balancer"
  value = module.load_balancer.dns_name
}
