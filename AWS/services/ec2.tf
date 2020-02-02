provider "aws" {
  region = "your preferred region"
}

# website::tag::1:: Deploy an EC2 Instance.
resource "aws_instance" "example" {
  # website::tag::2:: Run an Ubuntu 18.04 AMI on the EC2 instance.
  ami                    = "ami-01e074f40dfb9999d"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-021837c58cc9d682e"
  vpc_security_group_ids = ["sg-0bb51119484b8d9af"]
tags = {
    Name = "Terraform"
  }
}

# website::tag::5:: Output the instance's public IP address.
output "public_ip" {
  value = aws_instance.example.public_ip
}