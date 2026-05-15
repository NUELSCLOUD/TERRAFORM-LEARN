#=======================================
# CREATE EC2 INSTANCE RESOURCE
#=======================================
resource "aws_instance" "web" {
  ami           = "ami-0c94855ba95c71c99" # Amazon Linux 2 AMI (HVM), SSD Volume Type
  instance_type = var.instance_type[0] # Use the first instance type from the list
  count = var.instance_count # Number type: Instance count
  monitoring = var.monitoring  # Bool type: Enable monitoring and public IP
  associate_public_ip_address = var.associate_public_ip_address
  tags = {
    Name = "${var.environment}-web"
    Environment = var.environment
  #  (using first element from set)
    region =tolist(var.allowed_regions)[3] #  Set type: Availability zone. Use the second allowed region from the set
    created_by = "Terraform"
    
  }
}
#==============================================
# CREATE SECURITY GROUP RESOURCE 
#===============================================
resource "aws_security_group" "allow_tls" { 
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  

  tags = var.tags
}
#=======================================
# CREATE AWS VPC RESOURCE WITH TUPLE
#=======================================
resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = var.cidr_block[3] # Use the fourth cidr block from the list
  from_port         = var.ingress_values[0] # Use the first value from the tuple
  ip_protocol       = var.ingress_values[1] # Use the second value from the tuple
  to_port           = var.ingress_values[2] # Use the third value from the tuple
}
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

