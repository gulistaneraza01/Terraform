resource "aws_s3_bucket" "image-bucket_name" {
  bucket = "gulistane-${lower(var.name)}-1234"
}
