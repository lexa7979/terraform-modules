locals {
  http_port = 80
  any_port = 0
  any_protocol = "-1"
  all_ips = ["0.0.0.0/0"]
  load_balancer_type = "application"
}

# ALB (Application Load Balancer)
resource "aws_lb" "module_alb" {
  name = var.module_naming_prefix
  load_balancer_type = local.load_balancer_type
  subnets = data.aws_subnets.default.ids
  security_groups = [aws_security_group.module_alb.id]
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.module_alb.arn
  port = local.http_port
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

resource "aws_lb_listener_rule" "module_alb" {
  listener_arn = aws_lb_listener.http.arn
  priority = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.module_alb.arn
  }
}

resource "aws_security_group" "module_alb" {
  name = "${var.module_naming_prefix}-sec"

  # TODO: Move into "aws_security_group_rule" (p. 145)
  ingress {
    from_port = local.http_port
    to_port = local.http_port
    protocol = "tcp"
    cidr_blocks = local.all_ips
  }

  # TODO: Move into "aws_security_group_rule" (p. 145)
  egress {
    from_port = local.any_port
    to_port = local.any_port
    protocol = local.any_protocol
    cidr_blocks = local.all_ips
  }
}

# Target Group to check instances
resource "aws_lb_target_group" "module_alb" {
  name = "${var.module_naming_prefix}-chk"
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
