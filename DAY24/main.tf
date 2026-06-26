#=======================================
# CREATE S3 BUCKET RESOURCE
#=======================================
resource "aws_s3_bucket" "bucket1" {
  bucket = "${var.environment}-bucket1"
  tags = {
    Name = "${var.environment}-bucket1"
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
resource "aws_vpc" "selected" {
  cidr_block = "10.0.0.0/16"

}