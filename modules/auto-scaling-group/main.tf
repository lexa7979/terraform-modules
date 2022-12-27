locals {
  min_size = 2
  max_size = 4
  all_ips = ["0.0.0.0/0"]
}

resource "aws_autoscaling_group" "module" {
  launch_configuration = aws_launch_configuration.module.name
  vpc_zone_identifier = data.aws_subnets.default.ids

  target_group_arns = [var.target_group_arn]
  health_check_type = "ELB"

  min_size = local.min_size
  max_size = local.max_size

  tag {
    key = "Name"
    value = var.module_naming_prefix
    propagate_at_launch = true
  }
}

resource "aws_launch_configuration" "module" {
  image_id = var.instance_ami
  instance_type = var.instance_type
  security_groups = [aws_security_group.module.id]

  # TODO: Replace with templatefile("user-data.sh", ...) (p. 144 and chapter 3)
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

resource "aws_security_group" "module" {
  name = "${var.module_naming_prefix}-sec"

  # TODO: Move into "aws_security_group_rule" (p. 145)
  ingress {
    from_port   = var.webserver_port
    to_port     = var.webserver_port
    protocol    = "tcp"
    cidr_blocks = local.all_ips
  }
}
