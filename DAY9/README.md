<!-- BEGIN_TF_DOCS -->

# AWS Infrastructure with Terraform: Terraform Dynamic Blocks, Conditional Expressions, and Splat Expressions.

## 📋 Project Overview
This project implements the use of;
- **Conditional Expressions** - Make decisions in your configurations
- **Dynamic Blocks** - Create flexible, repeatable nested blocks
- **Splat Expressions** - Extract values from lists efficiently


# Learning Objectives

1. Master conditional expressions for environment-based configurations
2. Use dynamic blocks to eliminate code duplication
3. Apply splat expressions to extract data from multiple resources
4. Understand when to use each expression type
5. Combine multiple expression types for powerful configurations

## 🏗️ File Structure
The infrastructure is modularized into several key files to ensure maintainability and separation of concerns:

* **`main.tf`**: Contains the core resource definitions for AWS S3 Bucket. 
* **`variable.tf`**: Centralizes all input variables, showcasing a wide range of Terraform data types (List,bool, set, string).
* **`providers.tf`**: Configures the required AWS provider and version constraints for consistency.
* **`.gitignore`**: .gitignore file tells Git which files and folders it should not track or upload to your GitHub repository.
* **`README.md`**: documentation file that explains the project to anyone reading or using it.
* **`output.tf`**: Used to display important information after Terraform creates your infrastructure.
* **`locals.tf`**: reusable values or expressions that help make your Terraform code cleaner.

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
| [aws_instance.conditional_example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_instance.splat_example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_security_group.dynamic_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_ami.amazon_linux](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region for resources | `string` | `"us-east-1"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name (dev or prod) | `string` | `"dev"` | no |
| <a name="input_ingress_rules"></a> [ingress\_rules](#input\_ingress\_rules) | List of ingress rules for security group | <pre>list(object({<br/>    from_port   = number<br/>    to_port     = number<br/>    protocol    = string<br/>    cidr_blocks = list(string)<br/>    description = string<br/>  }))</pre> | <pre>[<br/>  {<br/>    "cidr_blocks": [<br/>      "0.0.0.0/0"<br/>    ],<br/>    "description": "HTTP",<br/>    "from_port": 80,<br/>    "protocol": "tcp",<br/>    "to_port": 80<br/>  },<br/>  {<br/>    "cidr_blocks": [<br/>      "0.0.0.0/0"<br/>    ],<br/>    "description": "HTTPS",<br/>    "from_port": 443,<br/>    "protocol": "tcp",<br/>    "to_port": 443<br/>  }<br/>]</pre> | no |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | Number of EC2 instances to create | `number` | `1` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for resources | `map(string)` | <pre>{<br/>  "Environment": "dev",<br/>  "Name": "dev-instance",<br/>  "commpliance": "yes",<br/>  "created_by": "terraform"<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_all_instance_ids"></a> [all\_instance\_ids](#output\_all\_instance\_ids) | All instance IDs using splat expression [*] |
| <a name="output_all_private_ips"></a> [all\_private\_ips](#output\_all\_private\_ips) | All private IPs using splat expression [*] |
| <a name="output_conditional_instance_id"></a> [conditional\_instance\_id](#output\_conditional\_instance\_id) | Instance ID of the conditional example |
| <a name="output_conditional_instance_type"></a> [conditional\_instance\_type](#output\_conditional\_instance\_type) | Instance type selected based on environment (prod=t3.large, dev=t2.micro) |
| <a name="output_dynamic_sg_id"></a> [dynamic\_sg\_id](#output\_dynamic\_sg\_id) | Security group ID with dynamic rules |
| <a name="output_security_group_rules_count"></a> [security\_group\_rules\_count](#output\_security\_group\_rules\_count) | Number of ingress rules created dynamically |



## 🚀 Deployment Guide
To deploy this infrastructure, follow the standard Terraform workflow:

1.  **Initialize**: `terraform init` (Initializes the S3 backend and downloads the AWS provider).
2.  **Validate**: `terraform validate` (Ensures configuration syntax is correct).
3.  **Plan**: `terraform plan` (Generates an execution plan to preview changes).
4.  **Apply**: `terraform apply` (Executes the plan to provision resources).



## Author

**NWAMU C. EMMANUEL**

DevOps & Cloud Engineering Enthusiast

<!-- END_TF_DOCS -->