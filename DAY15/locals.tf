# ========================================================
# Local values for AWS IAM User Management with Terraform
# ========================================================

# ====================
# Read users from CSV
# ====================
locals {
  users = csvdecode(file("users.csv"))
}