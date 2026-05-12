#=======================================
# RESOURCE TO CREATE TERRAFORM PROVIDER
#=======================================
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

#=========================================================================================
# RESOURCE TO CREATE TERRAFORM BACKEND WITH ENCRYPTION AND LOCKING ENABLED
#=========================================================================================
  backend "s3" {
    bucket = "nuel-tfstate"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    use_lockfile = true
    }
}

#=============================================
# RESOURCE TO CREATE AWS PROVIDER WITH REGION
#============================================
provider "aws" {
  region = "us-east-1"
}
