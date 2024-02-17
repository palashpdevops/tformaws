terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "ap-southeast-1"
  access_key = "AKIAV2VEDG37IFNRYSVD"
  secret_key = "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"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0fa377108253bf620"
  instance_type = "t2.micro"

  tags = {
    Name = "EC2withTform"
  }
}
