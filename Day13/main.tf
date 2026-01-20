data "aws_vpc" "vpc_name" {
  filter {
    name   = "tag:Name"
    values = ["default"]
  }
}

data "aws_subnet" "shared" {
  filter {
    name   = "tag:Name"
    values = ["default"]
  }
  vpc_id = data.aws_vpc.vpc_name.id
}

data "aws_ami" "ami_linux2" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

}

resource "aws_instance" "vm_react" {
  ami           = data.aws_ami.ami_linux2.id
  subnet_id     = data.aws_subnet.shared.id
  count         = 1
  instance_type = "t2.micro"
}
