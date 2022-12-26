terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  cloud {
    organization = "lexa79"

    workspaces {
      name = "learn-terraform-cloud"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.region
}

# EC2 - Elastic Compute Cloud
# resource "aws_instance" "app_server" {
#   ami                    = var.instance_ami
#   instance_type          = var.instance_type
#   vpc_security_group_ids = [aws_security_group.instance.id]
#
#   user_data = <<-EOF
#               #!/bin/bash
#               echo "Dummy webserver running" > index.html
#               nohup busybox httpd -f -p ${var.webserver_port} &
#               EOF
#   user_data_replace_on_change = true
#
#   tags = {
#     Name = var.instance_name
#   }
# }

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

  ingress {
    from_port   = var.webserver_port
    to_port     = var.webserver_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ASG (Auto Scaling Group)
resource "aws_autoscaling_group" "example" {
  launch_configuration = aws_launch_configuration.example.name
  vpc_zone_identifier = data.aws_subnets.default.ids

  target_group_arns = [aws_lb_target_group.asg.arn]
  health_check_type = "ELB"

  min_size = 2
  max_size = 10

  tag {
    key = "Name"
    value = "terraform-asg-example"
    propagate_at_launch = true
  }
}

# ASG: Launch Configuration
resource "aws_launch_configuration" "example" {
  image_id = var.instance_ami
  instance_type = var.instance_type
  security_groups = [aws_security_group.instance.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Dummy webserver running" > index.html
              nohup busybox httpd -f -p ${var.webserver_port} &
              EOF

  # Required when using a launch configuration with an autoscaling group:
  lifecycle {
    create_before_destroy = true
  }
}

# ASG: Query default VPC
data "aws_vpc" "default" {
  default = true
}

# ASG: Query subnets of default VPC
data "aws_subnets" "default" {
  filter {
    name = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# ASG: Target Group to check instances
resource "aws_lb_target_group" "asg" {
  name = "terraform-asg-example"
  port = var.webserver_port
  protocol = "HTTP"
  vpc_id = data.aws_vpc.default.id

  health_check {
    path = "/"
    protocol = "HTTP"
    matcher = "200"
    interval = 15
    timeout = 3
    healthy_threshold = 2
    unhealthy_threshold = 2
  }
}

# ALB (Application Load Balancer)
resource "aws_lb" "example" {
  name = "terraform-asg-example"
  load_balancer_type = "application"
  subnets = data.aws_subnets.default.ids
  security_groups = [aws_security_group.alb.id]
}

# ALB: Listener
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.example.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code = 404
    }
  }
}

# ALB: Listener rule
resource "aws_lb_listener_rule" "asg" {
  listener_arn = aws_lb_listener.http.arn
  priority = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.asg.arn
  }
}

resource "aws_security_group" "alb" {
  name = "terraform-example-alb"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
