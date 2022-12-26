# output "instance_id" {
#   description = "ID of the EC2 instance"
#   value       = aws_instance.app_server.id
# }

# output "instance_public_ip" {
#   description = "Public IP address of the EC2 instance"
#   value       = aws_instance.app_server.public_ip
# }

# output "instance_ami" {
#   value = aws_instance.app_server.ami
# }

# output "instance_arn" {
#   value = aws_instance.app_server.arn
# }

# output "instance_type" {
#   value = aws_instance.app_server.instance_type
# }

output "alb_dns_name" {
  description = "The domain name of the load balancer"
  value = aws_lb.example.dns_name
}
