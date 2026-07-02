# ==============================
# General Variables
# ==============================

variable "project_name" {
  description = "The name of the project."
  type        = string
  default     = "MYPROJECT"
  
}
variable "environment" {
  description = "The environment for the project (e.g., dev, staging, prod)."
  type        = string
  default     = "DEVELOPMENT"
  
}
variable "tags" {
  description = "A map of tags to apply to the resources."
  type        = map(string)
  default     = {
    Owner       = "Nuel"
    Department  = "IT"
    Environment = "Development"
  }

}
variable "vpc-tags" {
  description = "A map of tags to apply to the VPC resource."
  type        = map(string)
  default     = {
    Name       = "my-vpc"
    Assignment = "2"
  }
}
variable "sg_ports" {
  description = "Comma-separated list of ports to allow in the security group."
  type        = string
  default     = "22,80,443"
  
}
variable "instance_sizes" {
  description = "A map of environment to instance size."
  type        = map(string)
  default     = {
    development = "t2.micro"
    staging     = "t2.small"
    production  = "t2.medium"
  }
  
}
variable "allowed_ports" {
  description = "Comma-separated list of ports to allow in the security group."
  type        = string
  default     = "22,80,443"
  
}