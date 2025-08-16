variable "cidr" {
  default = "10.0.0.0/16"
}

variable "instance_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-014e30c8a36252ae5" # Update this to your desired AMI ID
}

variable "instance_type" {
  description = "Type of the EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default     = "wallaceterraform2025augproject" # Update this to your desired bucket name
}

variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-west-1"
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-west-1a", "us-west-1b"]
}