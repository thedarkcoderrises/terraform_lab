
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
    destination = "/home/ec2-user/docker/jenkins.sh"

    connection {
      host = self.public_ip
      type = "ssh"
      user = "ec2-user"
      private_key = "${file("~/.ssh/tf-manual-key.pem")}"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "cd /home/ec2-user/docker/",
      "sudo sh jenkins.sh"
    ]
  }
}

resource "aws_key_pair" "deployer" {
  key_name = "tf-manual-key"
  public_key = file("/Users/javabrain/Downloads/tf-manual-pub.txt")
}
