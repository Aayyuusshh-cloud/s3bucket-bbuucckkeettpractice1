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

locals {
  env = "prod"  

  instance_type = local.env == "prod" ? "t3.large" : "t2.micro"
}

output "selected_instance_type" {
  value = local.instance_type
}

