resource "aws_iam_user" "userlist" {
  count = length(var.username)
  name  = element(var.username, count.index)
}

resource "aws_iam_user_login_profile" "login_profile" {
  count                   = length(var.username)
  user                    = aws_iam_user.userlist[count.index].name
  password_length         = 16
  password_reset_required = true
}

resource "aws_iam_account_password_policy" "password_policy" {
  minimum_password_length        = 12
  require_uppercase_characters   = true
  require_lowercase_characters   = true
  require_numbers                = true
  require_symbols                = true
  allow_users_to_change_password = true
}

resource "aws_iam_user_group_membership" "user_group_membership" {
  count  = length(var.username) * length(var.existing_groups)
  user   = aws_iam_user.userlist[floor(count.index / length(var.existing_groups))].name
  groups = [var.existing_groups[count.index % length(var.existing_groups)]]
}

# resource "aws_iam_user_group_membership" "user_group_membership" {
#   count  = length(var.username)
#   user   = aws_iam_user.userlist[count.index].name
#   groups = [var.existing_group_name] # Referencing the existing group
# }

output "console_login_url" {
  value = var.console_login_url
  description = "The URL for the AWS Management Console login"
}

# Create the output file with usernames and passwords
resource "local_file" "user_credentials" {
  content = join("\n", [
    for i in range(length(var.username)) : 
    "Username: ${aws_iam_user.userlist[i].name}, Password: ${aws_iam_user_login_profile.login_profile[i].password}, Endpoint: ${var.console_login_url}"
  ]) 

  filename = "user_credentials.csv"
}

# resource "local_file" "user_credentials" {
#   content = join("\n\n", [
#     for i in range(length(var.username)) : 
#     <<EOT
# Username: ${aws_iam_user.userlist[i].name}
# Password: ${aws_iam_user_login_profile.login_profile[i].password}
# Endpoint: ${var.console_login_url}
# EOT
#   ])

#   filename = "user_credentials.csv"
# }


