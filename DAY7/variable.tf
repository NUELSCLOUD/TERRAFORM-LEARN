#=============================================
# CREATE ENVIRONMENT VARIABLE
#=============================================
variable "environment" {
  description = "The environment name"
  type        = string
  default     = "nuel-dev"
}
#=============================================
# CREATE S3 BUCKET COUNT VARIABLE
#=============================================
variable "s3_bucket_count" { 
  description = "Number of s3 bucket instances to create"
  type        = number
  default     = 2
}
#=============================================
# CREATE S3 BUCKET NAMES VARIABLE
#=============================================
variable "s3_bucket_names1" {
  description = "s3 bucket names for bucket1"
  type = list(string) # List type: S3 bucket names for bucket1
  default = [ "prodtech123","prodtech1234"]
}
#=============================================
# CREATE S3 BUCKET NAMES VARIABLE
#=============================================
variable "s3_bucket_names2" {
  description = "s3 bucket names for bucket2"
  type = list(string) # List type: S3 bucket names for bucket2
  default = [ "prodtech12345","prodtech123456"]
}
#=============================================
# CREATE S3 BUCKET TAGS VARIABLE
#=============================================
variable "s3_bucket_tags" {
  description = "s3 bucket tags"
  type = object({   # Object type: S3 bucket tags
    name = string
    environment = string
  })
  default = {
    environment = "nuel-dev"
    name = "nuel-dev"
  }
  
}

