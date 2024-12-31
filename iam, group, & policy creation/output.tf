output "user_arn" {
    value = aws_iam_user.userlist.*.arn
}
output "sre_group" {
    value = aws_iam_group.sre_group.id
    description = "A reference to the created IAM group"
  
}