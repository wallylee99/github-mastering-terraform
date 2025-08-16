provider "aws" {
  region = "us-west-1"
}

resource "aws_instance" "wallace" {
  instance_type = "t2.micro"
  ami           = "ami-014e30c8a36252ae5"
}

# resource "aws_s3_bucket" "s3_bucket" {
#   bucket = "wallace-s3-terraform-state-files"
# }

# Terraform supports state lock file in S3 now!!!
# resource "aws_dynamodb_table" "terraform_lock" {
#   name         = "terraform-lock"
#   billing_mode = "PAY_PER_REQUEST"
#   hash_key     = "LockID"

#   attribute {
#     name = "LockID"
#     type = "S"
#   }
# }
