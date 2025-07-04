provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "ap-south-1"
}

resource "aws_instance" "instance1" {
  ami           = "ami-0d03cb826412c6b0f"
  instance_type = "t2.micro"
  tags = {
    Name = "practinstance1"
  }
}

