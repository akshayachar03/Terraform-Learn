provider "aws" {
    region = "us-east-1"
  
}

variable "ami" {
    description = "Value of AMI ID"
  
}

variable "instance_type" {
    description = "Value of instance type"
  
}
resource "aws_instance" "akshay" {
    ami = var.ami
    instance_type = var.instance_type
  
}