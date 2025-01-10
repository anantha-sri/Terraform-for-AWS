resource "aws_iam_user" "userlist" {
  count = length(var.username)
  name  = element(var.username, count.index)
}

resource "aws_iam_group" "sre_group" {
  name = var.sre_group_name
}

resource "aws_iam_user_group_membership" "user_group_membership" {
  count  = length(var.username)
  user   = element(var.username, count.index)
  groups = [aws_iam_group.sre_group.name, ]
}

resource "aws_iam_policy" "policy" {
  name = var.policy_name

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
  name       = var.test-attach-name
  groups     = [aws_iam_group.sre_group.name]
  policy_arn = aws_iam_policy.policy.arn
}
