provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami = var.ami_id
  instance_type = var.instance_type
  key_name = var.key_name
}