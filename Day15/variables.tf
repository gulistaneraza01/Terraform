variable "primary_region" {
  description = "The AWS region for the primary provider"
  type        = string
  default     = "ap-south-1"
}

variable "secondary_region" {
  description = "The AWS region for the secondary provider"
  type        = string
  default     = "us-east-1"
}
