provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "ap-south-1"
}

resource "aws_s3_bucket" "bucket1" {
  bucket = "buucckkeettpractice1"
}
