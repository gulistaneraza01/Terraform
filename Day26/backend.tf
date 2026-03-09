terraform {
  backend "s3" {
    bucket       = "gulistaneraza-terraform-state"
    key          = "dev/day26/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}
