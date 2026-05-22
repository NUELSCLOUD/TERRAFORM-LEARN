<!-- BEGIN_TF_DOCS -->
# Terraform Functions Learning Guide

## Overview

Welcome to the Terraform Functions comprehensive learning guide! This covers Terraform's built-in functions through hands-on assignments with each assignment focuses on specific functions and real-world use cases.


## Learning Objectives

The learning objectives are:
1. Master Terraform's built-in functions across all categories
2. Understand when and how to use each function type
3. Know how to combine multiple functions effectively
4. Be proficient with the Terraform console for testing
5. Implement proper validation and error handling
6. Handle sensitive data securely
7. Create dynamic, reusable configurations


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
| [aws_instance.app_server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_instance.validated_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_resourcegroups_group.project](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/resourcegroups_group) | resource |
| [aws_s3_bucket.storage](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.timestamped_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_secretsmanager_secret.app_config](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.app_config](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_security_group.app_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc.sg_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_vpc.tagged_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_ami.amazon_linux](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_ami.validated_ami](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_ports"></a> [allowed\_ports](#input\_allowed\_ports) | Comma-separated list of allowed ports | `string` | `"80,443,8080,3306"` | no |
| <a name="input_backup_name"></a> [backup\_name](#input\_backup\_name) | Backup configuration name | `string` | `"daily_backup"` | no |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | S3 bucket name (must be globally unique) | `string` | `"ProjectAlphaStorageBucket with CAPS and spaces!!!"` | no |
| <a name="input_credential"></a> [credential](#input\_credential) | Sensitive credential | `string` | `"xyz123"` | no |
| <a name="input_default_locations"></a> [default\_locations](#input\_default\_locations) | Default AWS regions | `list(string)` | <pre>[<br/>  "us-west-1"<br/>]</pre> | no |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | n/a | `map(string)` | <pre>{<br/>  "company": "TechCorp",<br/>  "managed_by": "terraform"<br/>}</pre> | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name | `string` | `"dev"` | no |
| <a name="input_environment_tags"></a> [environment\_tags](#input\_environment\_tags) | n/a | `map(string)` | <pre>{<br/>  "cost_center": "cc-123",<br/>  "environment": "production"<br/>}</pre> | no |
| <a name="input_instance_sizes"></a> [instance\_sizes](#input\_instance\_sizes) | n/a | `map(string)` | <pre>{<br/>  "dev": "t2.micro",<br/>  "prod": "t3.large",<br/>  "staging": "t3.small"<br/>}</pre> | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | EC2 instance type | `string` | `"t2.micro"` | no |
| <a name="input_monthly_costs"></a> [monthly\_costs](#input\_monthly\_costs) | Monthly infrastructure costs (can include negative values for credits) | `list(number)` | <pre>[<br/>  -50,<br/>  100,<br/>  75,<br/>  200<br/>]</pre> | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of the project | `string` | `"Project ALPHA Resource"` | no |
| <a name="input_user_locations"></a> [user\_locations](#input\_user\_locations) | User-specified AWS regions | `list(string)` | <pre>[<br/>  "us-east-1",<br/>  "us-west-2",<br/>  "us-east-1"<br/>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_account_id"></a> [account\_id](#output\_account\_id) | Current AWS account ID |
| <a name="output_all_locations"></a> [all\_locations](#output\_all\_locations) | Combined list of all locations (with duplicates) |
| <a name="output_available_azs"></a> [available\_azs](#output\_available\_azs) | Available availability zones |
| <a name="output_average_cost"></a> [average\_cost](#output\_average\_cost) | Average monthly cost |
| <a name="output_backup_config"></a> [backup\_config](#output\_backup\_config) | Complete backup configuration |
| <a name="output_backup_credential"></a> [backup\_credential](#output\_backup\_credential) | Backup credential (sensitive) |
| <a name="output_backup_name"></a> [backup\_name](#output\_backup\_name) | Backup configuration name (validated) |
| <a name="output_bucket_arn"></a> [bucket\_arn](#output\_bucket\_arn) | ARN of created S3 bucket |
| <a name="output_config_data"></a> [config\_data](#output\_config\_data) | Configuration data from file (non-sensitive parts only) |
| <a name="output_config_directories"></a> [config\_directories](#output\_config\_directories) | Directory paths extracted from file paths |
| <a name="output_config_file_exists"></a> [config\_file\_exists](#output\_config\_file\_exists) | Whether config.json file exists |
| <a name="output_current_region"></a> [current\_region](#output\_current\_region) | Current AWS region |
| <a name="output_current_timestamp"></a> [current\_timestamp](#output\_current\_timestamp) | Current timestamp |
| <a name="output_environment"></a> [environment](#output\_environment) | Current environment |
| <a name="output_file_existence_status"></a> [file\_existence\_status](#output\_file\_existence\_status) | Status of each configuration file |
| <a name="output_formatted_bucket_name"></a> [formatted\_bucket\_name](#output\_formatted\_bucket\_name) | Formatted S3-compliant bucket name |
| <a name="output_formatted_ports"></a> [formatted\_ports](#output\_formatted\_ports) | Formatted port string for documentation |
| <a name="output_formatted_project_name"></a> [formatted\_project\_name](#output\_formatted\_project\_name) | Formatted project name (lowercase with hyphens) |
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | ID of created EC2 instance |
| <a name="output_instance_size"></a> [instance\_size](#output\_instance\_size) | Instance size selected via lookup |
| <a name="output_location_count"></a> [location\_count](#output\_location\_count) | Number of unique locations |
| <a name="output_max_cost"></a> [max\_cost](#output\_max\_cost) | Maximum monthly cost |
| <a name="output_merged_tags"></a> [merged\_tags](#output\_merged\_tags) | Combined default and environment tags |
| <a name="output_original_bucket_name"></a> [original\_bucket\_name](#output\_original\_bucket\_name) | Original bucket name input |
| <a name="output_original_costs"></a> [original\_costs](#output\_original\_costs) | Original monthly costs (with negatives) |
| <a name="output_port_list"></a> [port\_list](#output\_port\_list) | List of ports from comma-separated string |
| <a name="output_positive_costs"></a> [positive\_costs](#output\_positive\_costs) | All costs as positive values |
| <a name="output_resource_date_suffix"></a> [resource\_date\_suffix](#output\_resource\_date\_suffix) | Date formatted for resource names (YYYYMMDD) |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | Created resource group name |
| <a name="output_secret_arn"></a> [secret\_arn](#output\_secret\_arn) | ARN of AWS Secrets Manager secret |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | ID of created security group |
| <a name="output_security_group_rules"></a> [security\_group\_rules](#output\_security\_group\_rules) | Generated security group rules |
| <a name="output_tag_date_format"></a> [tag\_date\_format](#output\_tag\_date\_format) | Date formatted for tags (DD-MM-YYYY) |
| <a name="output_timestamped_bucket_name"></a> [timestamped\_bucket\_name](#output\_timestamped\_bucket\_name) | Timestamped S3 bucket name |
| <a name="output_total_cost"></a> [total\_cost](#output\_total\_cost) | Total monthly cost |
| <a name="output_unique_locations"></a> [unique\_locations](#output\_unique\_locations) | Unique set of locations (duplicates removed) |
| <a name="output_validated_instance_id"></a> [validated\_instance\_id](#output\_validated\_instance\_id) | ID of validated instance |
| <a name="output_validated_instance_type"></a> [validated\_instance\_type](#output\_validated\_instance\_type) | Validated instance type |
| <a name="output_vpc_tags"></a> [vpc\_tags](#output\_vpc\_tags) | Tags applied to VPC |


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