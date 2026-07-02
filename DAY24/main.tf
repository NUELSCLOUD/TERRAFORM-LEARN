#=======================================
# CREATE S3 BUCKET RESOURCE
#=======================================
resource "aws_s3_bucket" "bucket12" {
  bucket = "${var.environment}-bucket12"
  tags = {
    Name = "${var.environment}-bucket12"
    Environment = var.environment
  
  
  }
}
resource "aws_s3_bucket" "bucket21" {
  bucket = "${var.environment}-bucket21"
  tags = {
    Name = "${var.environment}-bucket21"
    Environment = var.environment

  
  }
}