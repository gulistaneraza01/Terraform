resource "aws_ami" "ami_user" {
  for_each = { for user in local.users : user.first_name => user }
  name     = each.value.first_name
}
