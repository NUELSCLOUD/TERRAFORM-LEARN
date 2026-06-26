#=======================================
# CREATE OUTPUT VARIABLES FOR VPC ID
#=======================================
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

#============================================
# CREATE OUTPUT VARIABLES FOR S3 BUCKET NAME
#============================================
output "bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.bucket.bucket
}