#=============================================
# CREATE PROVIDER CONFIGURATION FOR TERRAFORM
#==============================================
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}
#=======================================
# CREATE AWS PROVIDER CONFIGURATION
#=======================================
provider "aws" {
  region = "us-east-1"
}