#=======================================
# CREATE S3 BUCKET RESOURCE
#=======================================
resource "aws_s3_bucket" "bucket" {
  bucket = "${var.environment}-bucket"
  tags = {
    Name = "${var.environment}-bucket"
    Environment = var.environment
    region = "us-east-1"
  
  }
}
resource "aws_s3_bucket" "bucket2" {
  bucket = "${var.environment}-bucket2"
  tags = {
    Name = "${var.environment}-bucket2"
    Environment = var.environment
    region = "us-east-1"
  
  }
}