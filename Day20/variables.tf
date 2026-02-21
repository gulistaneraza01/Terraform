variable "s3_bucket_name" {
  description = "Name for the S3 bucket"
  type        = string
  default     = "raza-1234-1"
}

variable "tags" {
  description = "tags for application"
  type        = map(string)
  default = {
    "env"     = "prod"
    "version" = "1.0.0"
  }
}
