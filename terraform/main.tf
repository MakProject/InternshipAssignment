provider "aws" {
  region = var.aws_region
}

resource "aws_security_group" "instance_sg" {
  name        = "instance_sg"
  description = "Security group for EC2 instance"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
  
  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "instance_sg"
  }
}

resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  availability_zone = "ap-south-1a"
  associate_public_ip_address = true

  vpc_security_group_ids = [aws_security_group.instance_sg.id]

  tags = {
    Name = "web-instance"
  }
}

resource "aws_ebs_volume" "my_ebs" {
  availability_zone = "ap-south-1a"
  size              = 15
  type              = "gp3"

  tags = {
    Name = "my_ebs_volume"
  }
}

resource "aws_volume_attachment" "my_ebs_attachment" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.my_ebs.id
  instance_id = aws_instance.web.id
}

