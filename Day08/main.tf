# count meta augument
# resource "aws_s3_bucket" "bucket" {
#   count  = length(var.bucket_name)
#   bucket = var.bucket_name[count.index]
# }


# for_each meta argument
resource "aws_s3_bucket" "bucket" {
  for_each   = var.bucket_name
  bucket     = each.key
  depends_on = [aws_s3_bucket.bucket_map]
}

# for_each meta argument
resource "aws_s3_bucket" "bucket_map" {
  for_each = var.bucket_name_map
  bucket   = each.value
}
