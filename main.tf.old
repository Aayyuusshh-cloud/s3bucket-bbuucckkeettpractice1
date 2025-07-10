provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "ap-south-1"
}

resource "aws_s3_bucket" "bucket1" {
  bucket = "bbuucckkeettpractice1"

  tags = {
    Name = "bucket1st"
    Type = "dev"
  }
}

resource "aws_s3_bucket_versioning" "versioning_bucket1" {
  bucket = aws_s3_bucket.bucket1.id

  versioning_configuration {
    status = "Enabled"
  }

  depends_on = [aws_s3_bucket.bucket1]
}

