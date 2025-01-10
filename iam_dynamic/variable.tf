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
variable "existing_groups" {
  description = "The name of the existing IAM group in AWS"
  type        = list(string)
}

variable "console_login_url" {
  description = "The URL for the AWS Management Console login"
  type        = string  
}

