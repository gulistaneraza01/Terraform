resource "aws_instance" "vm_react" {
  ami           = data.aws_ami.ami_linux2.id
  subnet_id     = data.aws_subnet.shared.id
  count         = 1
  instance_type = "t2.micro"
}
