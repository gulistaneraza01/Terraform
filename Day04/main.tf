terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  cloud {

    organization = "GulistaneRaza_org"

    workspaces {
      name = "tf-cli"
    }
  }


}



# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "example_bucket" {
  bucket = "test-raza-oii"

  tags = {
    Name        = "example bucket"
    Environment = "Dev"
  }
}

