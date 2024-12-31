variable "username" {
    type = list(string)
    default = [ "Ajeeth", "Mani", "Darshan" ] 
}

resource "aws_iam_user" "userlist" {
    count = length(var.username)
    name  = element(var.username, count.index)
}

resource "aws_iam_group" "sre_group" {
    name = "SiteReliability"
}

resource "aws_iam_user_group_membership" "user_group_membership" {
    count  = length(var.username)
    user   = element(var.username, count.index)
    groups = [aws_iam_group.sre_group.name, ]
}

resource "aws_iam_policy" "policy" {
  name        = "sre-policy"
  description = "My test policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
          "ec2:Get*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_policy_attachment" "test-attach" {
  name       = "test-attachment"
  groups     = [aws_iam_group.sre_group.name]
  policy_arn = aws_iam_policy.policy.arn
}