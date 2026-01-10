resource "aws_instance" "vm_example" {
  instance_type = var.vm_type[0]
  ami           = "ami-0912f71e06545ad88"
  region        = "ap-south-1"

  lifecycle {
    create_before_destroy = true
  }
}
