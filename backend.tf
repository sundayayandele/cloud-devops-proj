terraform {
  backend "s3" {
    bucket     = "mys3tfbucket"
    region     = "us-east-2"
    key        = "remote-state-terraform-stores.tfstate"
    access_key = "xxxxxxxxxxxxxx"
    secret_key = "xxxxxxxxxxxxxxxxxxx"
  }
}