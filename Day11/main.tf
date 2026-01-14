resource "aws_s3_bucket" "image-bucket_name" {
  bucket = local.bucket_name
}

resource "aws_security_group" "allowed_ports" {
  name        = "allowed_ports"
  description = "Security group to allow specific ports"


  dynamic "ingress" {
    for_each = local.port_sg
    content {
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      description = ingress.value.describtion
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allowed_ports"
  }
}
