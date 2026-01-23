locals {
  content_types = {
    "html" = "text/html"
    "htm"  = "text/html"
    "css"  = "text/css"
    "js"   = "application/javascript"
    "json" = "application/json"
    "png"  = "image/png"
    "jpg"  = "image/jpeg"
    "jpeg" = "image/jpeg"
    "gif"  = "image/gif"
    "svg"  = "image/svg+xml"
    "ico"  = "image/x-icon"
    "txt"  = "text/plain"
    "xml"  = "application/xml"
    "pdf"  = "application/pdf"
    "csv"  = "text/csv"
  }

  s3_origin_id = "S3-${aws_s3_bucket.staic_web_page.id}"
}
