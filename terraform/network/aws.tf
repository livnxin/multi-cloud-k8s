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
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.57.1.0/27"

  tags = {
    role = "kubernetes"
  }
}
resource "aws_ec2_host" "control" {
  instance_type     = var.aws_control_flavor
  availability_zone = local.aws_zones[0]
  host_recovery     = "on"
  auto_placement    = "on"
}