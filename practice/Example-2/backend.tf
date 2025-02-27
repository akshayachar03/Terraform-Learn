terraform {
  backend "s3" {
    bucket = "akshaybucketfordemo"
    key = "akshay/terraform.tfstate"
  }
}