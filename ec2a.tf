provider "aws" {
  region = "ap-south-1"
}

resource "aws_key_pair" "key-pub" {
  key_name   = "key-pub"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDazDzEnsltvUW5IF9vVM7z/1jtBVO92lw4eICBEepJyqmGv3sjVmBGOJ499F1c1FV6y+DUhqCq7qPxniojbis1WKQwddtdagy0E7pUq2dM0epBODG5t6ec9kvhgJlFhNMLMooNv99kOf1vHIatogkp0Xmu51Uj5oUjkVD5Qn50y2avus3sIkCagLVtpEDWhO1Wba/OCmdSOXRIDp4jt4chgGBb6WsqhkygATbIlMmDt6J4A22sECa8JXoND2llOyWO65/b9x2tPI0eq50IjyYm7t7+JIcfrnv4bQLO/tNl6bxOfM948GvlUIUNu6zzhUMA4+vdq/cx69Xk5s8LLQcIz5p5Wa47Q+j/rrzuc0byQkw4MxnyE6a6oBHPaNBYKPKZenqiZdat+I6W3p9IfjPDRmAUdP2MDPNdNVyyuytRmqAk1fVuVe759MXsSHUWUkucdVQfBqAaTHFbWEFm1u2P1ekozCTDCrXuWnzVrAMcxpW37wt2K+3xExjs4nb9Y0a++QJ4/KrnplSA5i3EC1azzjJSKshTUfjW1tvtx27/PVSya9lDvhvp0wGxCe847ym9CGDc9yUAXlBNPssj4fuD5W2NoI012KTwRfbjK7RFjGZPS9ZBUw/QW20Ycons1lFOmpPq3j46hF45fwy2T9tLXd2MqdtU0UaFTQsEXAFOVw== root@localhost.localdomain"
}

resource "aws_security_group" "sg2" {
  name        = "sgpractice2"
  description = "Allow ssh,http"

  dynamic "ingress" {
    for_each = [22, 80]
    iterator = port
    content {
      description = "ssh, http ingress"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

resource "aws_instance" "instance2" {
  ami                    = "ami-0af9569868786b23a"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.key-pub.key_name
  vpc_security_group_ids = [aws_security_group.sg2.id]

  tags = {
    Name = "instance2"
  }
}

