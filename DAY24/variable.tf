#=======================================
# CREATE INPUT VARIABLES FOR ENVIRONMENT
#=======================================
variable "environment" {
  description = "The environment name"
  type        = string
  default     = "nuel-dev"
}
# variable for vpc
variable "vpc_id" {
  description = "The vpc id to deploy resources"
  type        = string 
  default     = ""
}