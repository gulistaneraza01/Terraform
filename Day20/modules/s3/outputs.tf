output "s3_url" {
  description = "URL of the created S3 bucket"
  value       = "https://s3.amazonaws.com/${aws_s3_bucket.bucket-setup.bucket}"
}
