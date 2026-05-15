<!-- BEGIN_TF_DOCS -->
# Terraform AWS Infrastructure Project

## Project Overview

This project uses Terraform Infrastructure as Code (IaC) to provision AWS cloud resources automatically.

The infrastructure created in this project includes:

# File Structure

```bash
.
├── main.tf
├── variables.tf
├── terraform.tfvars
├── backend.tf
├── outputs.tf
├── providers.tf
├── .gitignore
└── README.md
```
# Learning Objectives

This project demonstrates my ability to reorganize my previous Terraform configuration into separate files (backend.tf, provider.tf, variables.tf, , main.tf, outputs.tf) as well as understanding;

- Infrastructure as Code (IaC)
- Terraform workflow
- AWS provisioning
- Remote state management
- Terraform variables
- Resource tagging
- Git version control

---


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.43.0 |


## Resources

| Name | Type |
|------|------|
| [aws_instance.web](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_s3_bucket.bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name | `string` | `"nuel-dev"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_name"></a> [bucket\_name](#output\_bucket\_name) | The name of the S3 bucket |
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | The ID of the EC2 instance |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
<!-- END_TF_DOCS -->



## Author

**NWAMU C. EMMANUEL**

DevOps & Cloud Engineering Enthusiast
