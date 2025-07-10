provider "aws" {
  region = "ap-south-1" 
}
 
# VPC
resource "aws_vpc" "vpc1" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "main-vpc1"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "gw1" {
  vpc_id = aws_vpc.vpc1.id
  tags = {
    Name = "main-gw1"
  }
}
 
# Subnet
resource "aws_subnet" "subnet1" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "main-subnet1"
  }
}
 
# Route Table
resource "aws_route_table" "rt1" {
  vpc_id = aws_vpc.vpc1.id
  tags = {
    Name = "main-rt1"
  }
}
 
# Route to Internet
resource "aws_route" "it1" {
  route_table_id         = aws_route_table.rt1.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw1.id
}
 
# Associate Subnet with Route Table
resource "aws_route_table_association" "as1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.rt1.id
}
 
# Security Group allowing SSH
resource "aws_security_group" "sg1" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.vpc1.id
 
  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"] # Restrict in production!
  }
 
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
 
  tags = {
    Name = "allow-ssh"
  }
}
 
#create ssh key in aws
resource "aws_key_pair" "practicekey2" {
  key_name   = "practicekey"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDazDzEnsltvUW5IF9vVM7z/1jtBVO92lw4eICBEepJyqmGv3sjVmBGOJ499F1c1FV6y+DUhqCq7qPxniojbis1WKQwddtdagy0E7pUq2dM0epBODG5t6ec9kvhgJlFhNMLMooNv99kOf1vHIatogkp0Xmu51Uj5oUjkVD5Qn50y2avus3sIkCagLVtpEDWhO1Wba/OCmdSOXRIDp4jt4chgGBb6WsqhkygATbIlMmDt6J4A22sECa8JXoND2llOyWO65/b9x2tPI0eq50IjyYm7t7+JIcfrnv4bQLO/tNl6bxOfM948GvlUIUNu6zzhUMA4+vdq/cx69Xk5s8LLQcIz5p5Wa47Q+j/rrzuc0byQkw4MxnyE6a6oBHPaNBYKPKZenqiZdat+I6W3p9IfjPDRmAUdP2MDPNdNVyyuytRmqAk1fVuVe759MXsSHUWUkucdVQfBqAaTHFbWEFm1u2P1ekozCTDCrXuWnzVrAMcxpW37wt2K+3xExjs4nb9Y0a++QJ4/KrnplSA5i3EC1azzjJSKshTUfjW1tvtx27/PVSya9lDvhvp0wGxCe847ym9CGDc9yUAXlBNPssj4fuD5W2NoI012KTwRfbjK7RFjGZPS9ZBUw/QW20Ycons1lFOmpPq3j46hF45fwy2T9tLXd2MqdtU0UaFTQsEXAFOVw== root@localhost.localdomain"
}
 
# EC2 Instance
resource "aws_instance" "ec22" {
  ami           = "ami-0af9569868786b23a" 
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet1.id
  key_name = "${aws_key_pair.practicekey2.key_name}"
  vpc_security_group_ids = ["${aws_security_group.sg1.id}"]
 
  tags = {
    Name = "ec2-public"
  }
}
