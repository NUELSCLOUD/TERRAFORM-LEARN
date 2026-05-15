#==========================================
# CREATE TERRAFORM PROVIDER CONFIGURATION
#==========================================
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}
#==========================================
# CREATE TERRAFORM AWS CONFIGURATION
#==========================================
provider "aws" {
  region = "us-east-1"
}