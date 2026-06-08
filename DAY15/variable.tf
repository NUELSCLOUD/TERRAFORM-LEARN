# ==========================
# Variable for Region
# ==========================

variable "primary_region" {
  description = "Primary AWS region for the first VPC"
  type        = string
  default     = "us-east-1"
}
