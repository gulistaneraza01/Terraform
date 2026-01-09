variable "bucket_name" {
  type    = set(string)
  default = ["gulistane-bucket-1", "gulistane-bucket-2", "gulistane-bucket-2"]
}

variable "bucket_name_map" {
  type = map(string)
  default = {
    "bucket1" = "raza-0999",
    "bucket2" = "raza-0991",
  }

}
