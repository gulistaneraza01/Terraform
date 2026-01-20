locals {
  cost_numbers  = [for c in var.cost : tonumber(c)]
  total_cost    = sum(local.cost_numbers)
  positive_cost = sum([for c in local.cost_numbers : c if c > 0])
  native_cost   = sum([for c in local.cost_numbers : c if c < 0])
  max_cost      = max(local.cost_numbers...)
  min_cost      = min(local.cost_numbers...)
  
  current_timestamp          = timestamp()
  current_timestamp_formate1 = formatdate("DD-MM-YYYY", timestamp())
  current_timestamp_formate2 = formatdate("ddmmyyyy", timestamp())

  json_fileExist = fileexists("./config.json")
  json_data      = local.json_fileExist ? jsondecode(file("./config.json")) : {}
}
