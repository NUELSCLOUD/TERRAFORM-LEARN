#=======================================
# CREATE BACKEND CONFIGURATION FOR S3
#=======================================
terraform{
  backend "s3" {
    bucket = "nuelcruz-tfstate"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    use_lockfile = true
    }
}