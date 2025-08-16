provider "aws" {
  region = "us-west-1"
}

provider "vault" {
  address = "http://x.x.x.x:8200"
  skip_child_token = true

  auth_login {
    path = "auth/approle/login" # Use the AppRole auth method

    parameters = {
      role_id   = "42fb0f72-2c2a-abb9-7b8e-b2f73ac75e83"
      secret_id = "ba45c19c-206e-c201-f454-83f772ba5f40"
    }
  }
}

data "vault_kv_secret_v2" "example" {
  mount = "kv" # Change it according to your mount
  name  = "test-secret" #name of the secret in Vault
}

resource "aws_instance" "example" {
  ami           = "ami-014e30c8a36252ae5"
  instance_type = "t2.micro"

  tags = {
    Name   = "test"
    Secret = data.vault_kv_secret_v2.example.data["username"]
  }
}

resource "aws_s3_bucket" "example" {
  bucket = data.vault_kv_secret_v2.example.data["s3-bucket-name"]
}