# ==============================================================================
# Data source to get the existing VPC
# ==============================================================================
data "aws_vpc" "nuel" {
  filter {
    name = "tag:Name"
    values = [ "nuel-default" ]
  }
}
# ==============================================================================
# Data source to get the existing Subnet
# ==============================================================================
data "aws_subnet" "nuelcruz" {
  filter {
    name = "tag:Name"
    values = [ "nuel-subnet" ]
  }
  vpc_id = data.aws_vpc.nuel.id
}
# ==============================================================================
# Data source for the latest Amazon Linux 2 AMI
# ==============================================================================

data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "main" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = "t2.micro"
  subnet_id     = data.aws_subnet.nuelcruz.id
  region = var.region
  

  tags = {
    Name = "day12-instance"
  }
}
