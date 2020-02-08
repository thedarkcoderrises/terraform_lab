variable "ami_id" {
    default= "ami-01e074f40dfb9999d"
}

variable "instance_type" {
    default = "t2.micro"
}

variable "ec2_count" {
    default = "1"
}

variable "subnet_id" {}


variable "associate_public_ip_address" {
  default = "true"
}

variable "security_grp_id"{}