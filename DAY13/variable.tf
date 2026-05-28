# ==============================================================================
# ASSIGNMENT 2: Resource Tagging
# ==============================================================================

variable "default_tags" {
  type = map(string)
  default = {
    company    = "TechCorp"
    managed_by = "terraform"
  }
}

variable "environment_tags" {
  type = map(string)
  default = {
    environment = "production"
  
  }
}

# ==============================================================================
# ASSIGNMENT 3: S3 Bucket Naming
# ==============================================================================

variable "bucket_name" {
  type        = string
  description = "S3 bucket name (must be globally unique)"
  default     = "nuelcruz-hubz"
}
