
resource "aws_instance" "ec2_label" {
  count                  = var.ec2_count
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  associate_public_ip_address = var.associate_public_ip_address
  key_name = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [
      var.security_grp_id
  ]
  tags = {
      Name = "Terraform_EC2"
  }

  provisioner "file" {
    source      = "${path.module}/docker/jenkins.sh"
    destination = "/home/ec2-user/jenkins.sh"

    connection {
      host = self.public_ip
      type = "ssh"
      user = "ec2-user"
      private_key = "${file("~/.ssh/tf-manual-key.pem")}"
    }
  }

  provisioner "remote-exec" {
    connection {
      host = self.public_ip
      type = "ssh"
      user = "ec2-user"
      timeout = "5m"
      private_key = "${file("~/.ssh/tf-manual-key.pem")}"
    }

    inline = [
      "sudo yum update -y",
      "sudo yum -y install docker",
      "sudo service docker start",
      "sudo usermod -a -G docker ec2-user",
      "sudo chmod 666 /var/run/docker.sock",
      "docker info",
      "sudo sh /home/ec2-user/jenkins.sh"
    ]
  }
}

resource "aws_key_pair" "deployer" {
  key_name = "tf-manual-key"
  public_key = file("/Users/javabrain/Downloads/tf-manual-pub.txt")
}
