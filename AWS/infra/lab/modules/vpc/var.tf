variable "vpc_cidr" {
  default = "193.168.0.0/16"
}

variable "instance_tenancy" {
  default = "default"
}


variable "enable_dns_support" {
  default = "true"
}

variable "enable_dns_hostnames" {
  default = "true"
}

variable "vpc_id" {

}

variable "subnet_cidr" {
  default = "193.168.10.0/24"
}

variable "igw_id" {}

variable "pub_route_cidr" {
  default = "0.0.0.0/0"
}

variable "route_table_id" {}

variable "subnet_id" {}

variable "pvt_subnet_cidr" {}

variable "pvt_subnet_id" {}

variable "pvt_route_id" {}