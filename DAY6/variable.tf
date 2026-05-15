#=======================================
# CREATE ENVIRONMENT VARIABLE
#=======================================
variable "environment" {
  description = "The environment name"
  type        = string
  default     = "nuel-dev"
}
#=======================================
# CREATE INSTANCE COUNT VARIABLE(NUMBER TYPE)
#=======================================
variable "instance_count" { 
  description = "Number of EC2 instances to create"
  type        = number
  default     = 1
}
#=======================================
# CREATE REGION VARIABLE(STRING TYPE)
#=======================================
variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}
#=======================================
# CREATE MONITORING VARIABLE(BOOL TYPE)
#=======================================
variable "monitoring" {
  description = "Enable detailed monitoring for EC2 instances"
  type        = bool
  default     = false
}
#======================================================
# CREATE ASSOCIATE PUBLIC IP ADDRESS VARIABLE(BOOL TYPE)
#======================================================
variable "associate_public_ip_address" {
  description = "Whether to associate a public IP address with the EC2 instance"
  type        = bool
  default     = true
}
#=======================================
# CREATE CIDR BLOCK VARIABLE (LIST TYPE)
#=======================================
variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = list
  default     = ["10.0.0.0/16", "10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}
#==============================================
# CREATE INSTANCE TYPE VARIABLE (LIST TYPE)
#==============================================
variable "instance_type" {
  description = "The type of EC2 instance to create"
  type        = list(string)
  default     = ["t2.micro", "t2.small", "t2.medium", "t2.large"]
}
#=============================================================================
# CREATE ALLOWED_REGION VARIABLE (SET TYPE)- In set values can not be duplicate
#==============================================================================
variable "allowed_regions" {
  description = "Set of allowed AWS regions"
  type        = set(string)
  default     = ["us-east-1", "us-west-1", "eu-west-1", "ap-southeast-1", "us-east-1"]
}
#==============================================
# CREATE TAGS VARIABLE (MAP TYPE)
#==============================================
variable "tags" {
  description = "Map of tags to apply to resources"
  type        = map(string)
  default     = {
    Owner       = "Nuel Cruz"
    Project     = "Terraform Basics"
    Environment = "Development"
  }
  
}

#==============================================================================================================
# CREATE INGRESS_VALUES VARIABLE (TUPLE)- Accepts different kinds of datatype and has to be applied sequentially
#===============================================================================================================
variable "ingress_values" {
  description = "Tuple of values for security group ingress rules"
  type        = tuple([number, string, number])
  default     = [443, "tcp", 443]
}

#====================================================================================================
# CREATE CONFIGURATION VARIABLE (OBJECT)- Different datatypes in a single variable and can be accessed
# using dot notation
#=====================================================================================================
variable "configuration" {
  description = "Object variable for EC2 instance configuration"
  type        = object({
    instance_type = string
    ami           = string
    monitoring    = bool
  })
  default     = {
    instance_type = "t2.small"
    ami           = "ami-0c94855ba95c71c99" # Amazon Linux 2 AMI (HVM), SSD Volume Type
    monitoring    = true
  }
}



