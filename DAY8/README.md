<!-- BEGIN_TF_DOCS -->
# AWS Infrastructure with Terraform: Terraform Lifecycle Meta-arguments (AWS)

## 📋 Project Overview
This project implements Infrastructure as Code (IaC) to provision a standardized AWS environmen that enforces meta-arguments such as;
- `create_before_destroy` - Zero-downtime deployments
- `prevent_destroy` - Protect critical resources
- `ignore_changes` - Handle external modifications
- `replace_triggered_by` - Dependency-based replacements
- `precondition` - Pre-deployment validation
- `postcondition` - Post-deployment validation

# Learning Objectives
1. Understand all Terraform lifecycle meta-arguments
2. Know when to use each lifecycle rule
3. Be able to protect production resources
4. Implement zero-downtime deployments
5. Handle resources modified by external systems
6. Validate resources before and after creation


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
| [aws_autoscaling_group.app_servers](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_dynamodb_table.critical_app_data](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_instance.app_with_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_instance.web_server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_launch_template.app_server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_s3_bucket.app_buckets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.compliance_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.critical_data](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.regional_validation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_versioning.critical_data](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_security_group.app_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_ami.amazon_linux_2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_regions"></a> [allowed\_regions](#input\_allowed\_regions) | List of allowed AWS regions | `list(string)` | <pre>[<br/>  "us-east-1",<br/>  "us-west-2",<br/>  "eu-west-1",<br/>  "ap-south-1"<br/>]</pre> | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region for resources | `string` | `"us-east-1"` | no |
| <a name="input_bucket_names"></a> [bucket\_names](#input\_bucket\_names) | Set of S3 bucket names to create | `set(string)` | <pre>[<br/>  "demo-lifecycle-bucket-001",<br/>  "demo-lifecycle-bucket-002"<br/>]</pre> | no |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | Initial database name | `string` | `"myappdb"` | no |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | Database administrator password | `string` | `"ChangeMe123!"` | no |
| <a name="input_db_username"></a> [db\_username](#input\_db\_username) | Database administrator username | `string` | `"admin"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name (dev, staging, prod) | `string` | `"dev"` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | Name tag for EC2 instance | `string` | `"lifecycle-demo-instance"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | EC2 instance type | `string` | `"t2.micro"` | no |
| <a name="input_resource_tags"></a> [resource\_tags](#input\_resource\_tags) | Common tags to apply to resources | `map(string)` | <pre>{<br/>  "CostCenter": "Engineering",<br/>  "Environment": "dev",<br/>  "Team": "DevOps"<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_allowed_regions"></a> [allowed\_regions](#output\_allowed\_regions) | List of allowed regions for deployment |
| <a name="output_amazon_linux_ami_id"></a> [amazon\_linux\_ami\_id](#output\_amazon\_linux\_ami\_id) | ID of the Amazon Linux 2 AMI being used |
| <a name="output_amazon_linux_ami_name"></a> [amazon\_linux\_ami\_name](#output\_amazon\_linux\_ami\_name) | Name of the Amazon Linux 2 AMI |
| <a name="output_app_bucket_arns"></a> [app\_bucket\_arns](#output\_app\_bucket\_arns) | ARNs of application buckets |
| <a name="output_app_bucket_names"></a> [app\_bucket\_names](#output\_app\_bucket\_names) | Names of application buckets created with for\_each |
| <a name="output_app_instance_id"></a> [app\_instance\_id](#output\_app\_instance\_id) | ID of app instance with security group (replace\_triggered\_by example) |
| <a name="output_asg_desired_capacity"></a> [asg\_desired\_capacity](#output\_asg\_desired\_capacity) | Desired capacity of the ASG (this will be ignored in Terraform after manual changes) |
| <a name="output_asg_max_size"></a> [asg\_max\_size](#output\_asg\_max\_size) | Maximum size of the ASG |
| <a name="output_asg_min_size"></a> [asg\_min\_size](#output\_asg\_min\_size) | Minimum size of the ASG |
| <a name="output_asg_name"></a> [asg\_name](#output\_asg\_name) | Name of the Auto Scaling Group (ignore\_changes example) |
| <a name="output_compliance_bucket_name"></a> [compliance\_bucket\_name](#output\_compliance\_bucket\_name) | Name of the compliance bucket (postcondition example) |
| <a name="output_critical_bucket_arn"></a> [critical\_bucket\_arn](#output\_critical\_bucket\_arn) | ARN of the critical S3 bucket |
| <a name="output_critical_bucket_name"></a> [critical\_bucket\_name](#output\_critical\_bucket\_name) | Name of the critical S3 bucket (prevent\_destroy example) |
| <a name="output_current_region"></a> [current\_region](#output\_current\_region) | Current AWS region being used |
| <a name="output_dynamodb_table_arn"></a> [dynamodb\_table\_arn](#output\_dynamodb\_table\_arn) | ARN of the DynamoDB table |
| <a name="output_dynamodb_table_name"></a> [dynamodb\_table\_name](#output\_dynamodb\_table\_name) | Name of the DynamoDB table (multiple lifecycle rules example) |
| <a name="output_regional_validation_bucket"></a> [regional\_validation\_bucket](#output\_regional\_validation\_bucket) | Name of the region-validated bucket (precondition example) |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | ID of the application security group |
| <a name="output_security_group_name"></a> [security\_group\_name](#output\_security\_group\_name) | Name of the application security group |
| <a name="output_web_server_id"></a> [web\_server\_id](#output\_web\_server\_id) | ID of the web server instance (create\_before\_destroy example) |
| <a name="output_web_server_public_ip"></a> [web\_server\_public\_ip](#output\_web\_server\_public\_ip) | Public IP of the web server |

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