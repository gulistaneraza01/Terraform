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

variable "cidr_block" {
  description = "cidr block for vpc"
  type        = list(string)
  default     = ["10.0.0.0/8", "10.0.1.0/24", "172.168.0.0/16", "172.16.0.0/12"]
}


variable "allow_vm_types" {
  description = "allow vm types"
  type        = list(string)
  default     = ["t2.micro", "t2.small", "t2.medium"]
}

variable "allowed_regions" {
  description = "allowed regions"
  type        = set(string)
  default     = ["ap-south-1", "us-east-1", "us-west-1"]
}


variable "tags" {
  description = "tags"
  type        = map(string)
  default = {
    Name        = "allow_tls"
    Environment = "Dev"
  }
}
