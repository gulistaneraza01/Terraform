provider "aws" {
  region = "ap-south-1"
  alias  = var.primary
}

provider "aws" {
  region = "us-east-1"
  alias  = var.secondary
}
