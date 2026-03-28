locals {
    aws_zones = data.aws_availability_zones.aws_zones.names
}

data "aws_availability_zones" "aws_zones" {
}

resource "aws_vpc" "main_aws_vpc" {
  cidr_block       = "10.57.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "aws_kubernetes_node_subnet" {
  vpc_id     = aws_vpc.main_aws_vpc.id
  cidr_block = "10.57.1.0/24"

  tags = {
    role = "kubernetes"
  }
}

resource "aws_network_interface" "control_interface" {
  subnet_id   = aws_subnet.aws_kubernetes_node_subnet.id
  private_ips = ["10.57.1.11"]

  tags = {
    Name = "control_node_network_interface"
  }
}