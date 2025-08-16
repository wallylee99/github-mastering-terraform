provider "aws" {
  region = "us-west-1"
}

variable "ami_value" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type_value" {
  description = "Type of the EC2 instance"
  type        = string
}
resource "aws_instance" "example" {
  ami           = var.ami_value
  instance_type = var.instance_type_value
}