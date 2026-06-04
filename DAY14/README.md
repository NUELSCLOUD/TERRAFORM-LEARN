<!-- BEGIN_TF_DOCS -->
## Project
 VPC and Peering project

## Overview
This demo showcases **AWS VPC Peering** by creating two VPCs in different AWS regions and establishing a peering connection between them. This allows resources in both VPCs to communicate with each other using private IP addresses.


## Learning Outcomes
1. How to create VPC peering connections between regions
2. How to configure routing for VPC peering
3. How to set up security groups for cross-VPC communication
4. How to use Terraform provider aliases for multi-region deployments
5. How to test and verify VPC peering connectivity


## Architecture
```
┌─────────────────────────────────────┐       ┌─────────────────────────────────────┐
│     Primary VPC (us-east-1)         │       │    Secondary VPC (us-west-2)        │
│     CIDR: 10.0.0.0/16               │       │    CIDR: 10.1.0.0/16                │
│                                     │       │                                     │
│  ┌───────────────────────────────┐  │       │  ┌───────────────────────────────┐  │
│  │  Subnet: 10.0.1.0/24          │  │       │  │  Subnet: 10.1.1.0/24          │  │
│  │  ┌─────────────────────────┐  │  │       │  │  ┌─────────────────────────┐  │  │
│  │  │  EC2 Instance           │  │  │       │  │  │  EC2 Instance           │  │  │
│  │  │  Private IP: 10.0.1.x   │  │  │       │  │  │  Private IP: 10.1.1.x   │  │  │
│  │  └─────────────────────────┘  │  │       │  │  └─────────────────────────┘  │  │
│  └───────────────────────────────┘  │       │  └───────────────────────────────┘  │
│                                     │       │                                     │
│  Internet Gateway                   │       │  Internet Gateway                   │
└─────────────────┬───────────────────┘       └─────────────────┬───────────────────┘
                  │                                             │
                  └───────────────VPC Peering──────────────────┘
```



## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws.primary"></a> [aws.primary](#provider\_aws.primary) | 5.100.0 |
| <a name="provider_aws.secondary"></a> [aws.secondary](#provider\_aws.secondary) | 5.100.0 |


## Resources and Configurations

### Creating SSH Key Pairs
```bash
# For us-east-1
aws ec2 create-key-pair --key-name vpc-peering-demo-east --region us-east-1 --query 'KeyMaterial' --output text > vpc-peering-demo-east.pem

# For us-west-2
aws ec2 create-key-pair --key-name vpc-peering-demo-west --region us-west-2 --query 'KeyMaterial' --output text > vpc-peering-demo-west.pem

# Set permissions (on Linux/Mac)
chmod 400 vpc-peering-demo.pem
```

### Networking Components
1. **Two VPCs**:
   - Primary VPC in us-east-1 (10.0.0.0/16)
   - Secondary VPC in us-west-2 (10.1.0.0/16)

2. **Subnets**:
   - One public subnet in each VPC
   - Configured with auto-assign public IP

3. **Internet Gateways**:
   - One for each VPC to allow internet access

4. **Route Tables**:
   - Custom route tables with routes to internet and peered VPC
   - Routes for VPC peering traffic

5. **VPC Peering Connection**:
   - Cross-region peering between the two VPCs
   - Automatic acceptance configured

### Compute Resources
1. **EC2 Instances**:
   - One t2.micro instance in each VPC
   - Running Amazon Linux 2
   - Apache web server installed
   - Custom web page showing VPC information

2. **Security Groups**:
   - SSH access from anywhere (port 22)
   - ICMP (ping) allowed from peered VPC
   - All TCP traffic allowed between VPCs



| Name | Type |
|------|------|
| [aws_instance.primary_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_instance.secondary_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_internet_gateway.primary_igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_internet_gateway.secondary_igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_route.primary_to_secondary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.secondary_to_primary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.primary_rt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.secondary_rt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.primary_rta](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.secondary_rta](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.primary_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.secondary_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.primary_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.secondary_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.primary_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_vpc.secondary_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_vpc_peering_connection.primary_to_secondary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection) | resource |
| [aws_vpc_peering_connection_accepter.secondary_accepter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection_accepter) | resource |
| [aws_ami.primary_ami](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_ami.secondary_ami](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_availability_zones.primary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_availability_zones.secondary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | EC2 instance type | `string` | `"t2.micro"` | no |
| <a name="input_primary_key_name"></a> [primary\_key\_name](#input\_primary\_key\_name) | Name of the SSH key pair for Primary VPC instance (us-east-1) | `string` | `""` | no |
| <a name="input_primary_region"></a> [primary\_region](#input\_primary\_region) | Primary AWS region for the first VPC | `string` | `"us-east-1"` | no |
| <a name="input_primary_subnet_cidr"></a> [primary\_subnet\_cidr](#input\_primary\_subnet\_cidr) | CIDR block for the primary subnet | `string` | `"10.0.1.0/24"` | no |
| <a name="input_primary_vpc_cidr"></a> [primary\_vpc\_cidr](#input\_primary\_vpc\_cidr) | CIDR block for the primary VPC | `string` | `"10.0.0.0/16"` | no |
| <a name="input_secondary_key_name"></a> [secondary\_key\_name](#input\_secondary\_key\_name) | Name of the SSH key pair for Secondary VPC instance (us-west-2) | `string` | `""` | no |
| <a name="input_secondary_region"></a> [secondary\_region](#input\_secondary\_region) | Secondary AWS region for the second VPC | `string` | `"us-west-2"` | no |
| <a name="input_secondary_subnet_cidr"></a> [secondary\_subnet\_cidr](#input\_secondary\_subnet\_cidr) | CIDR block for the secondary subnet | `string` | `"10.1.1.0/24"` | no |
| <a name="input_secondary_vpc_cidr"></a> [secondary\_vpc\_cidr](#input\_secondary\_vpc\_cidr) | CIDR block for the secondary VPC | `string` | `"10.1.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_primary_instance_id"></a> [primary\_instance\_id](#output\_primary\_instance\_id) | ID of the Primary EC2 Instance |
| <a name="output_primary_instance_private_ip"></a> [primary\_instance\_private\_ip](#output\_primary\_instance\_private\_ip) | Private IP of the Primary EC2 Instance |
| <a name="output_primary_instance_public_ip"></a> [primary\_instance\_public\_ip](#output\_primary\_instance\_public\_ip) | Public IP of the Primary EC2 Instance |
| <a name="output_primary_vpc_cidr"></a> [primary\_vpc\_cidr](#output\_primary\_vpc\_cidr) | CIDR block of the Primary VPC |
| <a name="output_primary_vpc_id"></a> [primary\_vpc\_id](#output\_primary\_vpc\_id) | ID of the Primary VPC |
| <a name="output_secondary_instance_id"></a> [secondary\_instance\_id](#output\_secondary\_instance\_id) | ID of the Secondary EC2 Instance |
| <a name="output_secondary_instance_private_ip"></a> [secondary\_instance\_private\_ip](#output\_secondary\_instance\_private\_ip) | Private IP of the Secondary EC2 Instance |
| <a name="output_secondary_instance_public_ip"></a> [secondary\_instance\_public\_ip](#output\_secondary\_instance\_public\_ip) | Public IP of the Secondary EC2 Instance |
| <a name="output_secondary_vpc_cidr"></a> [secondary\_vpc\_cidr](#output\_secondary\_vpc\_cidr) | CIDR block of the Secondary VPC |
| <a name="output_secondary_vpc_id"></a> [secondary\_vpc\_id](#output\_secondary\_vpc\_id) | ID of the Secondary VPC |
| <a name="output_test_connectivity_command"></a> [test\_connectivity\_command](#output\_test\_connectivity\_command) | Command to test connectivity between VPCs |
| <a name="output_vpc_peering_connection_id"></a> [vpc\_peering\_connection\_id](#output\_vpc\_peering\_connection\_id) | ID of the VPC Peering Connection |
| <a name="output_vpc_peering_status"></a> [vpc\_peering\_status](#output\_vpc\_peering\_status) | Status of the VPC Peering Connection |



## 🚀 Deployment Guide
To deploy this infrastructure, follow the standard Terraform workflow:

1.  **Initialize**: `terraform init` (Initializes the S3 backend and downloads the AWS provider).
2.  **Validate**: `terraform validate` (Ensures configuration syntax is correct).
3.  **Plan**: `terraform plan` (Generates an execution plan to preview changes).
4.  **Apply**: `terraform apply` (Executes the plan to provision resources).
5.  **Destroy**: `terraform destroy` (destroys the provisioned resources).

## Testing VPC Peering

After the infrastructure is created, you can test the VPC peering connection:

### 1. Get Instance IPs
```bash
terraform output
```

### 2. Test Connectivity from Primary to Secondary
```bash
# SSH into Primary instance
ssh -i vpc-peering-demo-east.pem ubuntu@<PRIMARY_PUBLIC_IP>

# Ping the Secondary instance using its private IP
ping <SECONDARY_PRIVATE_IP>

# Test HTTP connectivity
curl http://<SECONDARY_PRIVATE_IP>
```

### 3. Test Connectivity from Secondary to Primary
```bash
# SSH into Secondary instance
ssh -i vpc-peering-demo-west.pem ubuntu@<SECONDARY_PUBLIC_IP>

# Ping the Primary instance using its private IP
ping <PRIMARY_PRIVATE_IP>

# Test HTTP connectivity
curl http://<PRIMARY_PRIVATE_IP>
```

## Key Concepts Demonstrated

### 1. VPC Peering
- Cross-region VPC peering connection
- Peering connection requester and accepter
- Automatic acceptance configuration

### 2. Routing
- Route tables with peering routes
- Traffic routing between VPCs
- Internet gateway routes

### 3. Security
- Security groups allowing cross-VPC traffic
- ICMP and TCP rules
- Proper egress rules

### 4. Multi-Region Deployment
- Using provider aliases for different regions
- Cross-region resource dependencies
- Regional AMI selection

## Important Notes

### CIDR Blocks
- VPC CIDR blocks **must not overlap** for peering to work
- Primary VPC: 10.0.0.0/16
- Secondary VPC: 10.1.0.0/16

### Costs
This demo creates resources that incur AWS charges:
- EC2 instances (t2.micro)
- Data transfer between regions
- VPC peering data transfer

**Remember to destroy resources when done:**
```bash
terraform destroy
```

## Troubleshooting

### Cannot Connect Between Instances
1. Check security groups allow traffic from the peered VPC CIDR
2. Verify route tables have routes to the peered VPC
3. Ensure VPC peering connection is in "active" state
4. Check NACL rules (if configured)

### Peering Connection Not Accepting
1. Ensure auto_accept is set to true in accepter resource
2. Check IAM permissions for cross-region operations
3. Verify VPC CIDR blocks don't overlap




## Author

**NWAMU C. EMMANUEL**

DevOps & Cloud Engineering Enthusiast


<!-- END_TF_DOCS -->



