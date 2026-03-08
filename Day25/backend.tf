terraform {
  backend "s3" {
    bucket       = "gulistaneraza-terraform-state"
    key          = "dev/day25-1/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}

