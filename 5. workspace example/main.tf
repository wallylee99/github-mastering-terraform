provider "aws" {
  region = "us-west-1"
}

variable "ami_value" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type_value" {
  description = "Type of the EC2 instance"
  #type        = string
  type = map(string)    #use map to allow different instance types for different environments

  default = {
    "dev" = "t2.micro"
    "stage" = "t2.small"
    "prod" = "t2.large"
  }
}

module "ec2_instance" {
  source              = "./modules/ec2_instance"
  ami_value           = var.ami_value
  #instance_type_value = var.instance_type_value
  instance_type_value = lookup(var.instance_type_value, terraform.workspace, "t2.micro") # Use lookup to get the instance type based on the workspace   
}