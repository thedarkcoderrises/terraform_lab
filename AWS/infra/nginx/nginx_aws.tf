provider "aws" {
  access_key = "your AWS access key"
    secret_key = "your AWS secret key"
    region = "your preferred region"
}

resource "aws_instance" "JB-TDCR-EC2-T2-MED-30G" {
  ami = "ami-0ad42f4f66f6c1cc9"
  instance_type = "t2.medium"
  tags = {
    Name = "JB-TDCR-EC2-T2-MED-30G"
  }
}

provider "docker" {
  host = "tcp://${aws_instance.JB-TDCR-EC2-T2-MED-30G.public_ip}:1234/"
}

resource "docker_image" "nginx" {
  name = "nginx:latest"
}

resource "docker_container" "nginx" {
  name = "nginx"
  image = "${docker_image.nginx.latest}"
  ports {
    external = 8080
    internal = 80
  }
}
#terraform import aws_instance.JB-TDCR-EC2-T2-MED-30G i-0b84ea6f7e41ef2d9; to use existing ec2 instance
#socat container to expose tcp port:1234; terraform to execute specified resources on ec2