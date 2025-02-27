terraform {
  backend "s3" {
    bucket = "akshaybucketfordemo"
    region = "us-east-1"
    key = "akshay/terraform.tfstate"
    dynamodb_table = "akshaydb"
  }
}