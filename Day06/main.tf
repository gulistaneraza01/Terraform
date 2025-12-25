resource "aws_s3_bucket" "image-store" {
  bucket = local.bucket-name
}
