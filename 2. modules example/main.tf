provider "aws" {
    region = "us-west-1"
}

module "ec2_instance" {
  source = "./module/ec2_instance"
  ami_value = "ami-014e30c8a36252ae5"
  instance_type_value = "t2.micro"
}
  