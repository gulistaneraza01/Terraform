resource "aws_instance" "node_server" {
  ami           = "ami-0912f71e06545ad88"
  instance_type = var.tags.env == "dev" ? "t2.micro" : "t2.large"
  count         = 2

  tags = var.tags
}


resource "aws_security_group" "node_server_sg" {
  name = "sg"

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

}

