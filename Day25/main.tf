resource "aws_s3_bucket" "demo-bucket" {
  bucket = "raza01-test-11"

  tags = {
    name = "raza"
  }
}
