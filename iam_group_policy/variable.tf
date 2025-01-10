variable "aws_access_key" {
  description = "AWS access key"
  type        = string
}

variable "aws_secret_key" {
  description = "AWS access key"
  type        = string
}

variable "username" {
  description = "List of usernames"
  type        = list(string)
}

variable "sre_group_name" {
  description = "Name of the group"
  type        = string
}

variable "policy_name" {
  description = "Policy to attach to the group"
  type        = string
}

variable "test-attach-name" {
  description = "Name of the policy attachment"
  type        = string  
}
