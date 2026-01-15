variable "s3_bucket_name" {
  description = "The name of the S3 bucket to be created."
  type        = string
  default     = "raza-bucket"

  validation {
    condition     = length(trimspace(var.s3_bucket_name)) > 0
    error_message = "Bucket name must be provided and cannot be empty."
  }
}

variable "credentials" {
  default   = "abc123"
  sensitive = true
}

variable "cost" {
  default = [-50, 100, 300, 500]
  type    = list(string)
}
