	locals {
  instance_count = 2 + 3
}
	resource "aws_instance" "demo" {
  count         = local.instance_count
  ami           = "ami-0af9569868786b23a"
  instance_type = "t2.micro"
	tags = {
    Name = "test-instance-${count.index}"
  }
}

