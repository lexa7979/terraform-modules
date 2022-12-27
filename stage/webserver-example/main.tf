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
      name = "stage-webserver-example"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.region
}

module "auto_scaling_group" {
  source = "github.com/lexa7979/terraform-modules//modules/auto-scaling-group"

  module_naming_prefix = "webserver-asg"
  instance_type = var.instance_type
  instance_ami = var.instance_ami
  webserver_port = var.webserver_port
  target_group_arn = module.load_balancer.target_group_arn
}

module "load_balancer" {
  source = "github.com/lexa7979/terraform-modules//modules/load-balancer"

  module_naming_prefix = "webserver-alb"
  webserver_port = var.webserver_port
}
