variable "region" {
  description = "The AWS region where the server will be deployed"
  type        = string
  default     = "ap-south-1"
}

variable "instance_count" {
  description = "number of instance are created"
  type        = string
  default     = 0
}

variable "environment" {
  description = "Environment like dev or prod"
  type        = string
  default     = "dev"
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP address with the instance"
  default     = false
  type        = bool
}
