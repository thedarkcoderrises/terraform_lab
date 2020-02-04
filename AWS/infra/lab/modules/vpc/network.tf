
#  VPC
resource "aws_vpc" "vpc_label" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = {
    Name = "JB-TDCR-TF-VPC"
  }
}


# Public Subnets
resource "aws_subnet" "pub_subnet_label" {
  cidr_block  = var.subnet_cidr
  vpc_id      = var.vpc_id

  tags = {
    Name     = "JB-TDCR-TF-PubSubnet"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw_label" {
  vpc_id   = var.vpc_id
    tags = {
      Name = "JB-TDCR-TF-IGW"
    }
}

# Public Routes
resource "aws_route_table" "pub_routes_label" {
  vpc_id = var.vpc_id
  route {
    cidr_block = var.pub_route_cidr
    gateway_id = var.igw_id
  }
  tags = {
    Name = "JB-TDCR-TF-PubRoute"
  }
}

# Associate/Link Public-Route With Public-Subnets
resource "aws_route_table_association" "pub_association_label" {
  route_table_id = var.route_table_id
  subnet_id      = var.subnet_id
}


# Private Subnets
resource "aws_subnet" "pvt_subnet_label" {
  cidr_block        = var.pvt_subnet_cidr
  vpc_id            = var.vpc_id

  tags = {
    Name    = "JB-TDCR-TF-PvtSubnet"
  }
}


# Private Route-Table For Private-Subnets
resource "aws_route_table" "pvt_routes_label" {
  vpc_id = var.vpc_id
  # route {
  #   cidr_block     = var.pvt_route_cidr
  # }
  tags = {
    Name = "JB-TDCR-TF-PvtRoute"
  }

}

# Associate/Link Private-Routes With Private-Subnets
resource "aws_route_table_association" "pvt-routes-linking" {
  subnet_id      = var.pvt_subnet_id
  route_table_id = var.pvt_route_id
}




output "vpc_id" {
  value = aws_vpc.vpc_label.id
}

output "subnet_id" {
  value = aws_subnet.pub_subnet_label.id
}

output "igw_id" {
  value = aws_internet_gateway.igw_label.id
}

output "route_table_id" {
  value = aws_route_table.pub_routes_label.id
}

output "pvt_subnet_id_out" {
  value = aws_subnet.pvt_subnet_label.id
}

output "pvt_route_id_out" {
  value = aws_route_table.pvt_routes_label.id
}



