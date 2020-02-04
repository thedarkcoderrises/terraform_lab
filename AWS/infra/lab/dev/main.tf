
provider "aws" {
  region = "ap-south-1"
}


module "tf_vpc" {
  source           = "../modules/vpc"
  vpc_cidr         = "193.168.0.0/16"
  instance_tenancy = "default"
  vpc_id           = "${module.tf_vpc.vpc_id}"
  subnet_cidr      = "193.168.10.0/24"
  igw_id           = "${module.tf_vpc.igw_id}"
  subnet_id        = "${module.tf_vpc.subnet_id}"
  route_table_id   = "${module.tf_vpc.route_table_id}"
  pvt_subnet_cidr  = "193.168.20.0/24"
  pvt_subnet_id    = "${module.tf_vpc.pvt_subnet_id_out}"
  pvt_route_id     = "${module.tf_vpc.pvt_route_id_out}"
}

module "tf_ec2" {
  source    = "../modules/ec2"
  ec2_count = 1
  ami_id = "ami-01e074f40dfb9999d"
  instance_type = "t2.micro"
  subnet_id = "${module.tf_vpc.subnet_id}"
}
