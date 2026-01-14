variable "name" {
  default = " Ra  za "
  type    = string
}

variable "bucket_name" {
  default = "  Gulistane RAza $$ 1234"
  type    = string
}

variable "ports" {
  default = "22,80,443,8000"
  type    = string
}

variable "env" {
  default = "prod"
  type    = string
}

variable "vm" {
  type = object({
    dev  = string
    prod = string
  })
  default = {
    dev  = "t2-micro"
    prod = "t3-large"
  }
}
