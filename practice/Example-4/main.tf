provider "aws" {
  region = "us-east-2"
}

provider "vault" {
  address = "http://3.89.91.172:8200"
  skip_child_token = true

  auth_login {
    path = "auth/approle/login"

    parameters = {
      role_id = "0adee87d-dc5c-340b-d89d-cbe8d0e77e3d"
      secret_id = "37537251-d5b6-42b2-803d-b377f3038492"
    }
  }
}

data "vault_kv_secret_v2" "example" {
  mount = "kv" // change it according to your mount
  name  = "test-secret" // change it according to your secret
}

resource "aws_instance" "my_instance" {
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"

  tags = {
    Secret = data.vault_kv_secret_v2.example.data["akshay"]
  }
}