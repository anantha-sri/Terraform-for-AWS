terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.64.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  access_key = "AKIAU6GDWK6S4ILSWMOC"
  secret_key = "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"
}