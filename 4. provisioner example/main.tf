terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.8.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "us-west-1"  # Replace with your desired AWS region.
}

variable "cidr" {
  default = "10.0.0.0/16"
}

resource "aws_key_pair" "example" {
  key_name   = "terraform-demo-wallace"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_vpc" "main" {
  cidr_block = var.cidr
}

resource "aws_subnet" "sub1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.0.0/24"  # Subnet CIDR block within the VPC range.
  availability_zone       = "us-west-1a"  # Replace with your desired availability zone.
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"    # Route all traffic to the internet, not the CIDR block.
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rta1" {
  subnet_id      = aws_subnet.sub1.id
  route_table_id = aws_route_table.main.id
}

resource "aws_security_group" "web_sg" {
  name   = "web"
  vpc_id = aws_vpc.main.id

    ingress {
    description = "HTTP from VPC"
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP traffic from anywhere.
    }
    ingress {
        description = "SSH"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]  # Allow SSH traffic from anywhere.
    }   
    egress {
        description = "Allow all outbound traffic"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"  # -1 means all protocols.
        cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic.
    }
}

resource "aws_instance" "web" {
  ami           = "ami-014e30c8a36252ae5"  # Replace with a valid AMI ID for your region.
  instance_type = "t2.micro"
  key_name      = aws_key_pair.example.key_name  # Use the key pair created above.
  subnet_id              = aws_subnet.sub1.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  associate_public_ip_address = true  # Ensure the instance has a public IP address.

  tags = {
    Name = "WebServer"
  }

# Tell Terraform how to connect to the instance.
  connection {
    type        = "ssh"
    user        = "ubuntu"  # Replace with the appropriate user for your AMI.
    private_key = file("~/.ssh/id_rsa")  # Path to your private key file.
    host        = self.public_ip  # Use the public IP of the instance for SSH connection.
  }

  # File provisioner to copy a file from local to the remote EC2 instance
  provisioner "file" {
    source      = "app.py"  # Replace with the path to your local file
    destination = "/home/ubuntu/app.py"  # Replace with the path on the remote instance
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Hello from the remote instance'",
      "sudo apt update -y",  # Update package lists (for ubuntu)
      "sudo apt-get install -y python3-venv",
      "cd /home/ubuntu",
      "python3 -m venv appenv",
      "/home/ubuntu/appenv/bin/pip install --upgrade pip",
      "/home/ubuntu/appenv/bin/pip install flask",
      "chmod +x /home/ubuntu/app.py",
      "/home/ubuntu/appenv/bin/python /home/ubuntu/app.py",
    ]
  }  
}