# ==============================================================================
# ASSIGNMENT 1: Project Naming Convention: Functions: lower(), replace()
# ==============================================================================
resource "aws_resourcegroups_group" "project" {
  name = local.formatted_project_name

  resource_query {
    query = jsonencode({
      ResourceTypeFilters = ["AWS::AllSupported"]
      TagFilters = [{
        Key    = "Project"
        Values = [local.formatted_project_name]
      }]
    })
  }

  tags = {
    Name    = local.formatted_project_name
    Project = local.formatted_project_name
  }
}

# ==============================================================================
# ASSIGNMENT 2: Resource Tagging: Function: merge()
# ==============================================================================

resource "aws_vpc" "tagged_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = local.merged_tags
}


# ==============================================================================
# ASSIGNMENT 3: S3 Bucket Naming: Functions: substr(), replace(), lower()
# ==============================================================================

resource "aws_s3_bucket" "storage" {
  bucket = local.formatted_bucket_name

  tags = {
    Name        = local.formatted_bucket_name
    Environment = var.environment
  }
}


# ============================================================================================
# ASSIGNMENT 4: Security Group Port Configuration: Functions: split(), join(), for expression
# ===========================================================================================

# Create a VPC specifically for this assignment (independent of Assignment 2)
resource "aws_vpc" "sg_vpc" {
  cidr_block = "10.1.0.0/16"

  tags = {
    Name       = "security-group-demo-vpc"
    Assignment = "4"
  }
}

resource "aws_security_group" "app_sg" {
  name        = "app-security-group"
  description = "Security group with dynamic ports"
  vpc_id      = aws_vpc.sg_vpc.id

  dynamic "ingress" {
    for_each = { for rule in local.sg_rules : rule.name => rule }
    content {
      description = ingress.value.description
      from_port   = tonumber(ingress.value.port)
      to_port     = tonumber(ingress.value.port)
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "app-security-group"
  }
}


# ==============================================================================
# ASSIGNMENT 5: Environment Configuration Lookup : Function: lookup()
# ==============================================================================

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "app_server" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = local.instance_size

  tags = {
    Name        = "app-server-${var.environment}"
    Environment = var.environment
    Size        = local.instance_size
  }
}
