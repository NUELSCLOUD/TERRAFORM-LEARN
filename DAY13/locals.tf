locals {
  # Merge default tags with environment-specific tags
  merged_tags = merge(var.default_tags, var.environment_tags)
}


