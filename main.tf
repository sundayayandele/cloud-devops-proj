terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

# Configure the AWS Key file
resource "aws_key_pair" "tf_key" {
  key_name   = var.key_name
  public_key = "ssh-rsa xxxxxxxxx"
}

# Configure the AWS Instance using RedHat Amazon Machine Image
resource "aws_instance" "jenkinsrv" {
  ami                    = var.ami
  monitoring             = true
  subnet_id              = aws_subnet.private_subnet1.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.tf_key.key_name
  user_data              = file("userdata.sh")
  vpc_security_group_ids = [aws_security_group.cloudevopsg.id]
  tags = {
    Name = "jenkins"
  }
}



