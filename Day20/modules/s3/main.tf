resource "aws_s3_bucket" "bucket-setup" {
  bucket = var.bucket_name

  tags = var.tags
}
