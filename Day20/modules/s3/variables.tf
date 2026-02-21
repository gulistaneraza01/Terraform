variable "bucket_name" {
  description = "name for the s3 bucket"
  type        = string
}


variable "tags" {
  description = "tags for s3"
  type        = map(string)
}
