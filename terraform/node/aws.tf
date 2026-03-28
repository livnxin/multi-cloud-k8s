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
  key_name = aws_key_pair.node_control_ssh_public_key.key_name

  tags = {
    role = "control"
  }
}

resource "aws_key_pair" "node_control_ssh_public_key" {
  key_name   = "control_keypair"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDTH0IkJRA4TaYHchNHDCKAnb+Sg37QglAQRbMl5yxpC8s5EykR2oWvnbpyOsBvh3aXorFMnxvyz47JO0MIiHXplF5xI1ndBOa0CLHadsqoq9vvj9pNRo3kwXAlsZqw3s3uhgggK4KylMgorPV78EGKIfTY07mYAkTO2MyOi8qFJOc++Jm+jPKrYzXBBnSo9evBkoF6taNzrLPB7c335AOgPJMffvyIJYgUddD8J+w+z+7NnJfEpKbVrrutDs1X8Gr2nsHAeU2AoB9h3VtOp2rqQ7Tag4fAdAn/X1oMaJDz2fHenYLAsyGgv/aaNJT0yuFHxrb7uiB06emuFWbJG5EJW5+LztmmspAVWghcNRZHnAVOgRrMfK3y1+4lDxzfBBvTnFMyJPjKly63q/3B2P5Zhkc+xaoAwBToGm9oagwPkLlNXSZ3xHMAbp0A39U90VH1sqJ+9RSDy+1uHTWhyAEuGuc6iafRQXmRivDUKTqhiZcFDYR+K6qP7Puw9XJ8798= lixin@RXRD"
}