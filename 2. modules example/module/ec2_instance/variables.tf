variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-west-1"
}

variable "ami_value" {
  description = "AMI ID for the EC2 instance"
  type        = string
  #default     = "ami-014e30c8a36252ae5" # Update this to your desired AMI ID
}

variable "instance_type_value" {
  description = "Type of the EC2 instance"
  type        = string
  #default     = "t2.micro"
}
