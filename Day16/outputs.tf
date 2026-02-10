output "current_account" {
  value = data.aws_caller_identity.current_account
}

output "userpassword" {
  value = {
    for user, profile in aws_iam_user_login_profile.users_login :
    user => "Password is created. Please reset your password the first time you log in."
  }
}
