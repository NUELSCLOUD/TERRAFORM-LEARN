
#============================================
# RESOURCE TO CREATE TERRAFORM PROVIDER
#========================================

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

#=======================================
# RESOURCE TO CREATE AWS PROVIDER
#======================================
provider "aws" {
  region = "us-east-1"
}


#=====================================
# RESOURCE TO CREATE VPC PROVIDER
#=====================================
resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
}


