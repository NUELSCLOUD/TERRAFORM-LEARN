# ========================================================
# Output values for AWS IAM User Management with Terraform
# ========================================================

# ==================
# Output user names
# ==================
output "user_names" {
  value = [for user in local.users : "${user.first_name} ${user.last_name}"]
}

# =====================
# Output user_passwords
# =====================
output "user_passwords" {
  value = {
    for user, profile in aws_iam_user_login_profile.users :
    user => profile.password
  }
  sensitive = true
}
