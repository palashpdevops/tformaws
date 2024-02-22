terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0fa377108253bf620"
  instance_type = "t2.micro"

  tags = {
    Name = "EC2withTform"
  }
}
