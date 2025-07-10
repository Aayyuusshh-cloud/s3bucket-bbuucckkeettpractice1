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

resource "aws_security_group" "practice_sg" {
  name        = "practice_sg"
  description = "Allow ssh and HTTP"

  ingress {
    description = "ssh ingress"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP ingress"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

