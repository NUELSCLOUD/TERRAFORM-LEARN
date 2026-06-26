#=======================================
# CREATE S3 BUCKET RESOURCE
#=======================================
resource "aws_s3_bucket" "bucket1" {
  bucket = "${var.environment}-bucket1"
  tags = {
    Name = "${var.environment}-bucket1"
    Environment = var.environment
  
  
  }
}
resource "aws_s3_bucket" "bucket2" {
  bucket = "${var.environment}-bucket2"
  tags = {
    Name = "${var.environment}-bucket2"
    Environment = var.environment

  
  }
}