
#========================
# CREATE VPC RESOURCE
#========================
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${var.environment}-vpc"
    Environment = var.environment
    region = "us-east-1"
  }
}

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

#=======================================
# CREATE EC2 INSTANCE RESOURCE
#=======================================
resource "aws_instance" "web" {
  ami           = "ami-0c94855ba95c71c99" # Amazon Linux 2 AMI (HVM), SSD Volume Type
  instance_type = "t2.micro"
  tags = {
    Name = "${var.environment}-web"
    Environment = var.environment
    region = "us-east-1"
    
  }
}