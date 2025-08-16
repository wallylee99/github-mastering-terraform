#For maintain state file in S3 bucket
terraform {
  backend "s3" {
    bucket = "wallace-s3-terraform-state-files"
    key    = "wallace/terraform.tfstate"
    region = "us-west-1"
    dynamodb_table = "terraform-lock"
  }
}
