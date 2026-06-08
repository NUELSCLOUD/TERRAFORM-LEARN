# =======================
# Provider for Terraform
# =======================
terraform {
required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
# =============================================
# Provider for aws region (us-east-1)
# =============================================
provider "aws" {
  region = var.primary_region
  alias = "primary"
}
