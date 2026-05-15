<!-- BEGIN_TF_DOCS -->
# AWS Infrastructure with Terraform: Standardized EC2 & VPC Security Deployment

## 📋 Project Overview
This project implements Infrastructure as Code (IaC) to provision a standardized AWS environment. It focuses on deploying a scalable EC2 web instance layer and a secure networking tier using Terraform. The project demonstrates advanced DevOps practices, including remote state management, strict variable typing, and security hardening.

## 🎯 Learning Objectives & DevOps Best Practices
This project serves as a reference for several critical Terraform and DevOps concepts:

### 1. Advanced Data Types
The configuration utilizes diverse variable types to handle data with precision:
* **List**: Used for `instance_type` and `cidr_block` to allow indexed selection of values. 
* **Set**: Utilized for `allowed_regions` to ensure no duplicate entries are present. 
* **Tuple**: Applied to `ingress_values` to store a fixed-size, ordered sequence of different data types (Port, Protocol).
* **Object**: Defines complex structures for EC2 configurations, including AMI and monitoring settings.
* **Map**: Manages resource metadata via `tags`.

### 2. State Management & Security
* **Remote Backend**: State is stored in an S3 bucket with `use_lockfile = true` to enable safe, concurrent team deployments. 
* **Monitoring**: The configuration includes optional detailed monitoring for EC2 instances to enhance observability.
* **Network Security**: Uses a dedicated Security Group for TLS traffic, enforcing strict ingress (Port 443) and universal egress rules. 

## 🛠️ Infrastructure Components
* **Compute**: AWS EC2 instances provisioned with Amazon Linux 2 AMIs. The instance count is dynamically adjusted based on the environment
* **Networking**: A VPC-bound Security Group (`allow_tls`) that manages inbound and outbound traffic rules.
* **Metadata**: Consistent tagging across all resources for ownership and project tracking. 

## 🏗️ File Structure
The infrastructure is modularized into several key files to ensure maintainability and separation of concerns:

* **`main.tf`**: Contains the core resource definitions for AWS EC2 instances, security groups, and network rules. 
* **`variable.tf`**: Centralizes all input variables, showcasing a wide range of Terraform data types (List, Set, Map, Tuple, Object).
* **`terraform.tfvars`**: Defines environment-specific values (e.g., production instance counts) to keep configurations dynamic.
* **`providers.tf`**: Configures the required AWS provider and version constraints for consistency.
* **`backend.tf`**: Implements a remote S3 backend with state locking to support team collaboration and prevent state corruption. 
* **`.gitignore`**: .gitignore file tells Git which files and folders it should not track or upload to your GitHub repository.
* **`README.md`**: documentation file that explains the project to anyone reading or using it.


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.43.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_instance.web](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_security_group.allow_tls](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc_security_group_egress_rule.allow_all_traffic_ipv4](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.allow_tls_ipv4](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_regions"></a> [allowed\_regions](#input\_allowed\_regions) | Set of allowed AWS regions | `set(string)` | <pre>[<br/>  "us-east-1",<br/>  "us-west-1",<br/>  "eu-west-1",<br/>  "ap-southeast-1",<br/>  "us-east-1"<br/>]</pre> | no |
| <a name="input_associate_public_ip_address"></a> [associate\_public\_ip\_address](#input\_associate\_public\_ip\_address) | Whether to associate a public IP address with the EC2 instance | `bool` | `true` | no |
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | CIDR block for the VPC | `list` | <pre>[<br/>  "10.0.0.0/16",<br/>  "10.0.1.0/24",<br/>  "10.0.2.0/24",<br/>  "10.0.3.0/24"<br/>]</pre> | no |
| <a name="input_configuration"></a> [configuration](#input\_configuration) | Object variable for EC2 instance configuration | <pre>object({<br/>    instance_type = string<br/>    ami           = string<br/>    monitoring    = bool<br/>  })</pre> | <pre>{<br/>  "ami": "ami-0c94855ba95c71c99",<br/>  "instance_type": "t2.small",<br/>  "monitoring": true<br/>}</pre> | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name | `string` | `"nuel-dev"` | no |
| <a name="input_ingress_values"></a> [ingress\_values](#input\_ingress\_values) | Tuple of values for security group ingress rules | `tuple([number, string, number])` | <pre>[<br/>  443,<br/>  "tcp",<br/>  443<br/>]</pre> | no |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | Number of EC2 instances to create | `number` | `1` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The type of EC2 instance to create | `list(string)` | <pre>[<br/>  "t2.micro",<br/>  "t2.small",<br/>  "t2.medium",<br/>  "t2.large"<br/>]</pre> | no |
| <a name="input_monitoring"></a> [monitoring](#input\_monitoring) | Enable detailed monitoring for EC2 instances | `bool` | `false` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region to deploy resources | `string` | `"us-east-1"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to apply to resources | `map(string)` | <pre>{<br/>  "Environment": "Development",<br/>  "Owner": "Nuel Cruz",<br/>  "Project": "Terraform Basics"<br/>}</pre> | no |


## 🚀 Deployment Guide
To deploy this infrastructure, follow the standard Terraform workflow:

1.  **Initialize**: `terraform init` (Initializes the S3 backend and downloads the AWS provider).
2.  **Validate**: `terraform validate` (Ensures configuration syntax is correct).
3.  **Plan**: `terraform plan` (Generates an execution plan to preview changes).
4.  **Apply**: `terraform apply` (Executes the plan to provision resources).


## Best Practices

1. **Always specify types** for variables
2. **Use validation blocks** for business rules
3. **Provide meaningful error messages**
4. **Use appropriate collection types** (list vs set vs map)
5. **Validate complex objects** thoroughly
6. **Use type conversion functions** when needed
7. **Document type requirements** in descriptions


## Author

**NWAMU C. EMMANUEL**

DevOps & Cloud Engineering Enthusiast


<!-- END_TF_DOCS -->






