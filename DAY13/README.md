<!-- BEGIN_TF_DOCS -->
# Static Website Hosting (Mini Project)

## 🎯 Project Overview

This mini project demonstrates how to deploy a static website on AWS using Terraform. We'll create a complete static website hosting solution using S3 for storage and CloudFront for global content delivery.

## 📚 Learning Objectives

- ✅ How to configure S3 for static website hosting
- ✅ Setting up CloudFront distributions
- ✅ Managing S3 bucket policies and public access
- ✅ Terraform file provisioning with `for_each`
- ✅ Proper MIME type configuration for web assets
- ✅ AWS CDN concepts and caching strategies


## 🏗️ Architecture

```
Internet → CloudFront Distribution → S3 Bucket (Static Website)
```

### Components:
- **S3 Bucket**: Hosts static website files (HTML, CSS, JS)
- **CloudFront Distribution**: Global CDN for fast content delivery
- **Public Access Configuration**: Allows public reading of website files


## 🔧 Configuration Details

### S3 Configuration:
- **Bucket naming**: Auto-generated with prefix `nuelcruz-hubz`
- **Website hosting**: Enabled with `index.html` as default
- **Public access**: Configured for read-only public access
- **Content types**: Proper MIME types for web files

### CloudFront Configuration:
- **Origin**: S3 bucket regional domain
- **Caching**: Standard web caching (1 hour default TTL)
- **HTTPS**: Automatic redirect from HTTP to HTTPS
- **Global**: Available worldwide (PriceClass_100)


## 📁 Project Structure

```
day14/
├── main.tf              # Main Terraform configuration
├── variables.tf         # Input variables
├── outputs.tf          # Output values
├── README.md           # This file
└── www/                # Website source files
    ├── index.html      # Main HTML page
    ├── style.css       # Stylesheet
    └── script.js       # JavaScript functionality
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.100.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudfront_distribution.s3_distribution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |
| [aws_cloudfront_origin_access_control.oac](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_control) | resource |
| [aws_s3_bucket.nuel-bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_policy.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.access_block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_object.website-files](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | S3 bucket name (must be globally unique) | `string` | `"nuelcruz-hubz"` | no |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | n/a | `map(string)` | <pre>{<br/>  "company": "TechCorp",<br/>  "managed_by": "terraform"<br/>}</pre> | no |
| <a name="input_environment_tags"></a> [environment\_tags](#input\_environment\_tags) | n/a | `map(string)` | <pre>{<br/>  "environment": "production"<br/>}</pre> | no |

## 🚀 Deployment Guide
To deploy this infrastructure, follow the standard Terraform workflow:

1.  **Initialize**: `terraform init` (Initializes the S3 backend and downloads the AWS provider).
2.  **Validate**: `terraform validate` (Ensures configuration syntax is correct).
3.  **Plan**: `terraform plan` (Generates an execution plan to preview changes).
4.  **Apply**: `terraform apply` (Executes the plan to provision resources).
5.  **Destroy**: `terraform destroy` (destroys the provisioned resources).



## Author

**NWAMU C. EMMANUEL**

DevOps & Cloud Engineering Enthusiast


<!-- END_TF_DOCS -->