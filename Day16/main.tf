resource "aws_iam_user" "users" {
  for_each = { for user in local.users : "${lower(user.first_name)}.${lower(user.last_name)}" => user }
  name     = lower("${each.value.first_name}.${each.value.last_name}")
  path     = "/departments/${lower(each.value.department)}/"

  tags = {
    DisplayName = "${each.value.first_name} ${each.value.last_name}"
    Department  = each.value.department
    JobTitle    = each.value.job_title
  }
}

resource "aws_iam_user_login_profile" "users_login" {
  for_each                = aws_iam_user.users
  user                    = each.value.name
  password_reset_required = true

  lifecycle {
    ignore_changes = [password_reset_required, password_length]
  }
}

resource "aws_iam_group" "educations_group" {
  name = "Education"
  path = "/groups/"
}

resource "aws_iam_group" "sales_group" {
  name = "Sales"
  path = "/groups/"
}

resource "aws_iam_user_group_membership" "educations_membership" {
  for_each = {
    for k, user in aws_iam_user.users : k => user if user.tags["Department"] == "Education"
  }

  user   = each.value.name
  groups = [aws_iam_group.educations_group.name]
}

resource "aws_iam_user_group_membership" "sales_membership" {
  for_each = {
    for k, user in aws_iam_user.users : k => user if user.tags["Department"] == "Sales"
  }

  user   = each.value.name
  groups = [aws_iam_group.sales_group.name]
  
}
