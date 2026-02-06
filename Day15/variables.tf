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

variable "primary_cidr" {
  description = "The CIDR block for the primary VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "secondary_cidr" {
  description = "The CIDR block for the secondary VPC"
  type        = string
  default     = "10.1.0.0/16"
}

variable "instance_type" {
  description = "Instance type for ec2 machine"
  type        = string
  default     = "t2.micro"
}

variable "primary_key_name" {
  description = "key pair for SSH primary instance"
  type        = string
  default     = ""
}

variable "secondary_key_name" {
  description = "key pair for SSH secondary instance"
  type        = string
  default     = ""
}
