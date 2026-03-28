data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "control" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  primary_network_interface {
    network_interface_id = var.control_interface_id
  }

  associate_public_ip_address = false
  key_name                    = aws_key_pair.node_control_ssh_public_key.key_name

  tags = {
    role = "control"
  }
}

resource "aws_instance" "workers" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  count = var.worker_count

  primary_network_interface {
    network_interface_id = var.worker_interface_id
  }

  associate_public_ip_address = false
  key_name                    = aws_key_pair.node_worker_ssh_public_key.key_name

  tags = {
    role = "workers"
  }
}

resource "aws_key_pair" "node_control_ssh_public_key" {
  key_name   = "control_keypair"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDTH0IkJRA4TaYHchNHDCKAnb+Sg37QglAQRbMl5yxpC8s5EykR2oWvnbpyOsBvh3aXorFMnxvyz47JO0MIiHXplF5xI1ndBOa0CLHadsqoq9vvj9pNRo3kwXAlsZqw3s3uhgggK4KylMgorPV78EGKIfTY07mYAkTO2MyOi8qFJOc++Jm+jPKrYzXBBnSo9evBkoF6taNzrLPB7c335AOgPJMffvyIJYgUddD8J+w+z+7NnJfEpKbVrrutDs1X8Gr2nsHAeU2AoB9h3VtOp2rqQ7Tag4fAdAn/X1oMaJDz2fHenYLAsyGgv/aaNJT0yuFHxrb7uiB06emuFWbJG5EJW5+LztmmspAVWghcNRZHnAVOgRrMfK3y1+4lDxzfBBvTnFMyJPjKly63q/3B2P5Zhkc+xaoAwBToGm9oagwPkLlNXSZ3xHMAbp0A39U90VH1sqJ+9RSDy+1uHTWhyAEuGuc6iafRQXmRivDUKTqhiZcFDYR+K6qP7Puw9XJ8798= lixin@RXRD"
}

resource "aws_key_pair" "node_worker_ssh_public_key" {
  key_name   = "worker_keypair"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDIRgwV2Wq7XCGLP6PFy36QQD9jl9f7NJxFRB7L67kt5pIGdzMsJbTD1uejgvWJuF1OAaSp90aZ69dn3WQp1I/4Zdex+w2MfY16MZAK3D17nJmyXglmptXowgQuy9Fm/EKJ7f1CaQSKgOIcV2+TF89sYdGD2BuvNxJNdCiFh6zIX5H37k7RgMLuBZURi/HOE+4pKH9yHBjE36lyt+rmSAaJ3E/58CQdc1iLiWhEpxWzx4OPtVfBvs2ofmtzm4yBDP41I4Pl3xK7PysWE8IXg8ArbitLV+GQsSP3RQ5VX6EDsYvRZTeKli2+vj3+jsjxNWepjCdPbKqNtGdB/qAx1RDlGU+XvxdBAR02Ki81r6m5xiXI/f3RTj3V1J+dDA+G3vORlJB1c0rXd3OL8z4EBhy6Lrft61KyYKBzxhYG2xPrXzptDfzGyZ7nWCK7va3wmRuun37ZAujgt5mf6p975eWMKqPZ1OE9ye8x+KCKH2/OxZCAdxqjZx2vxYBET/Awaw0= lixin@RXRD"
}