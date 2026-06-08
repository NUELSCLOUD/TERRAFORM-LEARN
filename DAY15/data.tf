# ========================================================
# Data Sources for AWS IAM USER MANAGEMANET WITH TERRAFROM
# ========================================================

# =====================
# Get AWS Account ID
# =====================
data "aws_caller_identity" "current" {}
