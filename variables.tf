variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "ExampleAppServerInstanceJuly22"
}

variable "instance_type" {
  description = "Type of EC2 instance to provision"
  type        = string
  default     = "t3.micro"
}

variable "instance_ami" {
  description = "ID of the Amazon Machine Image to be used"
  type        = string
  default     = "ami-0440e5026412ff23f"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-north-1"
}
