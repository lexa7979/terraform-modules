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

# AWS glossary

- AMI: Amazon Machine Images
  https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AMIs.html

- VPC: Virtual Private Cloud
  https://eu-north-1.console.aws.amazon.com/vpc/home

- EC2: Elastic Compute Cloud
