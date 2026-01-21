resource "aws_s3_bucket" "staic_web_page" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_public_access_block" "static_public_block" {
  bucket = aws_s3_bucket.staic_web_page.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


resource "aws_cloudfront_origin_access_control" "static_oac" {
  name                              = "aoc"
  description                       = "Policy"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}
