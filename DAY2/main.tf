
#=============================================
# RESOURCE TO CREATE TERRAFORM PROVIDER
#=============================================
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

#==========================================
# RESOURCE TO CREATE AWS PROVIDER
#==========================================
provider "aws" {
  region = "us-east-1"
}

#==========================================
# RESOURCE TO CREATE S3 BUCKET WITH TAGS
#==========================================
resource "aws_s3_bucket" "example" {
  bucket = "my-tf-test-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

