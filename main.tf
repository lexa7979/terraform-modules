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

module "auto_scaling_group" {
  source = "./modules/auto-scaling-group"

  module_naming_prefix = "example-asg"
  instance_type = var.instance_type
  instance_ami = var.instance_ami
  webserver_port = var.webserver_port
  target_group_arn = module.load_balancer.target_group_arn
}

module "load_balancer" {
  source = "./modules/load-balancer"

  module_naming_prefix = "example-alb"
  webserver_port = var.webserver_port
}
