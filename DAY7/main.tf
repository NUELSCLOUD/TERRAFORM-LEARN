#==========================================
# CREATE AWS S3 BUCKET RESOURCE
#==========================================
resource "aws_s3_bucket" "bucket1" {
  depends_on = [ aws_s3_bucket.bucket2 ] # Ensure bucket1 is created after bucket2 to avoid circular dependency
  bucket = var.s3_bucket_names1[count.index] # Use the bucket name from the list based on the count index
  count = var.s3_bucket_count # Number type: Bucket count
  tags = var.s3_bucket_tags
}
#==========================================
# CREATE AWS S3 BUCKET RESOURCE
#==========================================
resource "aws_s3_bucket" "bucket2" {
  bucket = each.value # Use the bucket name from the list based on the for_each key
  for_each = toset(var.s3_bucket_names2) # Convert the list to a set for for_each
  tags = var.s3_bucket_tags
}
