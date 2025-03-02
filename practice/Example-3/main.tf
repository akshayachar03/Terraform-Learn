provider "aws" {
    region = "us-east-1"
  
}

variable "ami" {
    description = "value of AMI"
  
}

variable "instance_type" {
    description = "value of instance type"
    type = map(string)

    default = {
      "dev" = "t2.micro"
      "prod" = "t2.large"
    }
  
}

module "ec2_instance" {
    source = "./modules/ec2_instance"
    ami = var.ami
    instance_type = lookup(var.instance_type, terraform.workspace, "t2.micro")
  
}