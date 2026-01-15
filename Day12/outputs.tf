output "bucket_name" {
  value = var.s3_bucket_name
}


output "credentials" {
  value     = var.credentials
  sensitive = true
}

output "total_cost" {
  value = local.total_cost
}

output "positive_cost" {
  value = local.positive_cost
}

output "native_cost" {
  value = local.native_cost
}

output "min_cost" {
  value = local.min_cost
}

output "max_cost" {
  value = local.max_cost
}

output "current_timestamp" {
  value = local.current_timestamp
}

output "json_fileExist" {
  value = local.json_fileExist
}
output "json_data" {
  value = local.json_data.postgres.password
}

