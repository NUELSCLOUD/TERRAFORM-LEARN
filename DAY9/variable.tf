variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-1"
}
# Create a variable for tags
variable "tags" {
  description = "Tags for resources"
  type        = map(string)
  default     = {
    Environment = "dev"
    Name        = "dev-instance"
    created_by  = "terraform"
    commpliance   = "yes"
  }
}

variable "environment" {
  description = "Environment name (dev or prod)"
  type        = string
  default     = "dev"
}

variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
  default     = 1
}

variable "ingress_rules" {
  description = "List of ingress rules for security group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
  default = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "HTTP"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "HTTPS"
    }
  ]
}
