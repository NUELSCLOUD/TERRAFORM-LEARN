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
#=======================================
# RESOURCE TO CREATE TERRAFORM BACKEND WITH ENCRYPTION AND LOCKING ENABLED
#=======================================
  # backend "s3" {
  #   bucket = "nuel-tfstate"
  #   key    = "dev/terraform.tfstate"
  #   region = "us-east-1"
  #   encrypt = true
  #   use_lockfile = true
  # }
 }
#=======================================
# RESOURCE TO CREATE AWS PROVIDER
#======================================
provider "aws" {
  region = "us-east-1"
}
  

#=======================================
# CREATE ENVIRONMENT VARIABLE
#=======================================
variable "environment" {
  description = "The environment name"
  type        = string
  default     = "dev"
  
}
#=======================================
# RESOURCE PROVISIONING FOR VPC
#=======================================
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${var.environment}-vpc"
    Environment = var.environment
  }
}
#=======================================
# RESOURCE PROVISIONING FOR S3 BUCKET
#=======================================
resource "aws_s3_bucket" "bucket" {
  bucket = "${var.environment}-bucket"
  tags = {
    Name = "${var.environment}-bucket"
    Environment = var.environment

  }
}
#=======================================
# RESOURCE PROVISIONING FOR EC2 INSTANCE
#=======================================
resource "aws_instance" "web" {
  ami           = "ami-0c94855ba95c71c99" # Amazon Linux 2 AMI (HVM), SSD Volume Type
  instance_type = "t2.micro"
  tags = {
    Name = "${var.environment}-web"
    Environment = var.environment
  }
}
#=======================================
# OUTPUT VARIABLES FOR VPC ID
#=======================================
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}
#=======================================
# OUTPUT VARIABLES FOR S3 BUCKET NAME
#=======================================
output "bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.bucket.bucket
}
#=======================================
# OUTPUT VARIABLES FOR EC2 INSTANCE ID
#=======================================
output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.web.id
}
