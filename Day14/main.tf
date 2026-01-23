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

resource "aws_s3_bucket_policy" "allow_cloud_front" {
  bucket     = aws_s3_bucket.staic_web_page.id
  depends_on = [aws_s3_bucket_public_access_block.static_public_block]
  policy     = data.aws_iam_policy_document.allow_access_from_another_account.json
}


data "aws_iam_policy_document" "allow_access_from_another_account" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions = ["s3:ListBucket"]
    resources = [
      aws_s3_bucket.staic_web_page.arn
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.s3_distribution.arn]
    }
  }

  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions = ["s3:GetObject"]
    resources = [
      "${aws_s3_bucket.staic_web_page.arn}/*"
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.s3_distribution.arn]
    }
  }
}

resource "aws_s3_object" "object" {
  for_each = fileset("${path.module}/www", "**/*")
  bucket   = aws_s3_bucket.staic_web_page.id
  key      = each.value
  source   = "${path.module}/www/${each.value}"

  etag = filemd5("${path.module}/www/${each.value}")

  content_type = lookup(
    local.content_types,
    lower(regex("\\.([^.]+)$", each.value)[0]),
    "application/octet-stream"
  )
}


resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              = aws_s3_bucket.staic_web_page.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.static_oac.id
    origin_id                = local.s3_origin_id
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Some comment"
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Environment = "production"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
    # acm_certificate_arn = data.aws_acm_certificate.my_domain.arn
    # ssl_support_method  = "sni-only"
  }
}
