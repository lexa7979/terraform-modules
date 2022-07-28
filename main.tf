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

resource "aws_instance" "app_server" {
  ami           = var.instance_ami
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }
}
