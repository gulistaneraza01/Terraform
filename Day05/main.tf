terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket       = "gulistaneraza-terraform-state"
    key          = "dev/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}


provider "aws" {
  region = "ap-south-1"
}


variable "environment" {
  default = "dev"
  type    = string
}
variable "bucket-name" {
  type    = string
  default = "raza"
}

locals {
  bucket-name = "gulistane-raza-1232-${var.environment}"
}



resource "aws_s3_bucket" "bucket-demo" {
  bucket = local.bucket-name

  tags = {
    Name        = "${var.bucket-name}-main-bucket"
    Environment = var.environment
  }
}

resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name        = "main-vpc"
    Environment = var.environment
  }
}


output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "s3_id" {
  value = aws_s3_bucket.bucket-demo.id
}

