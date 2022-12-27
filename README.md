# Terraform

## Interesting details

- Store state remotely
  https://www.terraform.io/language/state/remote

  > The Terraform state file is the only way Terraform can track which resources it manages, and often contains sensitive information, so you must store your state file securely and restrict access to only trusted team members who need to manage your infrastructure. In production, we recommend storing your state remotely with Terraform Cloud or Terraform Enterprise. Terraform also supports several other remote backends you can use to store and manage your state.

- Variables
  https://learn.hashicorp.com/tutorials/terraform/variables?in=terraform/configuration-language

  > Setting variables via the command-line will not save their values. Terraform supports many ways to use and set variables so you can avoid having to enter them repeatedly as you execute commands. To learn more, follow our in-depth tutorial, Customize Terraform Configuration with Variables.

- Use VCS-Driven Workflow with Terraform Cloud
  https://learn.hashicorp.com/tutorials/terraform/cloud-vcs-change?in=terraform/cloud-get-started
  > In addition to the CLI-driven workflow, Terraform Cloud offers a VCS-driven workflow that automatically triggers runs based on changes to your VCS repositories. The CLI-driven workflow allows you to quickly iterate on your configuration and work locally, while the VCS-driven workflow enables collaboration within teams by establishing your shared repositories as the source of truth for infrastructure configuration.

## `terraform init`

- Changed backend
- Changed provider
- Changed modules

## `terraform graph`

- http://dreampuf.github.io/GraphvizOnline/

## `terraform plan` and `terraform apply`

## `terraform output`

## `terraform destroy`

## Book "Terraform: Up and Running" (3rd edition)

- Chapter 1 "Why Terraform"
- Chapter 2 "Getting Started with Terraform"
  - Elastic Compute Cloud
  - Auto Scaling Group
  - Elastic Load Balancer
- Chapter 3 "How to Manage Terraform State"
- Chapter 4 "How to Create Reusable Infrastructure with Terraform Modules"
- Chapter 5 "Terraform Tips and Tricks: Loops, If-Statements, Deployment, and Gotchas"
- Chapter 6 "Managing Secrets with Terraform"
- Chapter 7 "Working with Multiple Providers"
- Chapter 8 "Production-Grade Terraform Code"
- Chapter 9 "How to Test Terraform Code"
- Chapter 10 "How to Use Terraform as a Team"

# Terraform Cloud

- **Please note:** Local modules can be used inside subfolders (e.g. `source = "./modules/load-balancer"`) but not with relative paths leading out of the current working directory (e.g. `source = "../modules/load-balancer`).

## Starting with new workspace

- Adapt "terraform.cloud.workspaces.name" in main.tf
- Run "terraform init"
- Open workspace from https://app.terraform.io/app/lexa79/workspaces
- On page "Variables" use "Apply variable set" and add set "AWS Credentials"

# AWS glossary

> "Amazon Web Services in Plain English": https://expeditedsecurity.com/aws-in-plain-english/

- ARN: Amazon Resource Name

- AMI: Amazon Machine Images
  https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AMIs.html

- VPC: Virtual Private Cloud
  https://eu-north-1.console.aws.amazon.com/vpc/home

- EC2: Elastic Compute Cloud

- ASG: Auto Scaling Group

  > An ASG takes care of a lot of tasks for you completely automatically, including launching a cluster of EC2 Instances, monitoring the health of each Instance, replacing failed Instances, and adjusting the size of the cluster in response to load.

  > These days, you should actually be using a launch template (and the aws_launch_template resource) with ASGs rather than a launch configuration.

- AZ: Availability Zone (datacenter)
  https://aws.amazon.com/de/about-aws/global-infrastructure/regions_az/

- ELB: Elastic Load Balancer
  Three types: ALB (Application: HTTP, HTTPS), NLB (Network: TCP, UDP, TLS), CLB (Classic)
