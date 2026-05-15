<!-- BEGIN_TF_DOCS -->
# AWS Infrastructure with Terraform: Standardized EC2 & VPC Security Deployment

## 📋 Project Overview
This project implements Infrastructure as Code (IaC) to provision a standardized AWS environment. It focuses on deploying a scalable EC2 web instance layer and a secure networking tier using Terraform. The project demonstrates advanced DevOps practices, including remote state management, strict variable typing, and security hardening.

# Learning Objectives
- Focuses on `count` vs `for_each` meta-arguments, dependency management via `depends_on`, and complex variable typing
- Learn when to use `count` vs `for_each`
- Practice creating multiple AWS resources efficiently


## 🏗️ File Structure
The infrastructure is modularized into several key files to ensure maintainability and separation of concerns:

* **`main.tf`**: Contains the core resource definitions for AWS S3 Bucket. 
* **`variable.tf`**: Centralizes all input variables, showcasing a wide range of Terraform data types (List, Object).
* **`providers.tf`**: Configures the required AWS provider and version constraints for consistency.
* **`.gitignore`**: .gitignore file tells Git which files and folders it should not track or upload to your GitHub repository.


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
| [aws_s3_bucket.bucket1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.bucket2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name | `string` | `"nuel-dev"` | no |
| <a name="input_s3_bucket_count"></a> [s3\_bucket\_count](#input\_s3\_bucket\_count) | Number of s3 bucket instances to create | `number` | `2` | no |
| <a name="input_s3_bucket_names1"></a> [s3\_bucket\_names1](#input\_s3\_bucket\_names1) | s3 bucket names for bucket1 | `list(string)` | <pre>[<br/>  "prodtech123",<br/>  "prodtech1234"<br/>]</pre> | no |
| <a name="input_s3_bucket_names2"></a> [s3\_bucket\_names2](#input\_s3\_bucket\_names2) | s3 bucket names for bucket2 | `list(string)` | <pre>[<br/>  "prodtech12345",<br/>  "prodtech123456"<br/>]</pre> | no |
| <a name="input_s3_bucket_tags"></a> [s3\_bucket\_tags](#input\_s3\_bucket\_tags) | s3 bucket tags | <pre>object({   # Object type: S3 bucket tags<br/>    name = string<br/>    environment = string<br/>  })</pre> | <pre>{<br/>  "environment": "nuel-dev",<br/>  "name": "nuel-dev"<br/>}</pre> | no |


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








<!-- BEGIN_TF_DOCS -->




