resource "aws_instance" "node_server" {
  ami                         = "resolve:ssm:/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
  instance_type               = "t2.micro"
  count                       = var.instance_count
  region                      = var.region
  associate_public_ip_address = var.associate_public_ip_address
}
