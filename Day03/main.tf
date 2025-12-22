terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Create an S3 Bucket
resource "aws_s3_bucket" "react-bucket" {
  bucket = "react-bucket-raza"

  tags = {
    Name        = "new bucket"
    Environment = "Dev"
  }
}
