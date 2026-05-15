# AWS Infrastructure Provisioning with Terraform

## Project Overview

This Terraform project provisions basic AWS infrastructure resources including:

* AWS VPC
* Amazon S3 Bucket
* EC2 Instance
* Terraform Variables
* Terraform Outputs

The infrastructure is parameterized using Terraform variables to support different deployment environments such as:

* development
* staging
* production

---

# Technologies Used

* Terraform
* AWS Provider
* Amazon VPC
* Amazon S3
* Amazon EC2

---

# Project Structure

```text id="9gnj2k"
.
├── main.tf
├── terraform.tfvars
└── README.md
```

---

# Infrastructure Resources Created

This project provisions the following AWS resources:

| Resource     | Purpose                                  |
| ------------ | ---------------------------------------- |
| VPC          | Creates isolated AWS networking          |
| S3 Bucket    | Stores objects/files                     |
| EC2 Instance | Creates a virtual server                 |
| Outputs      | Displays important infrastructure values |

---

# Terraform Configuration Breakdown

---

# 1. Terraform Block

```hcl id="rlx5ep"
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}
```

## Purpose

This block tells Terraform:

* which provider to use
* where to download it from
* acceptable provider version

---

# AWS Provider Version

```text id="1qad6e"
hashicorp/aws ~> 6.0
```

This means:

* use AWS provider version 6.x
* but not version 7.x

---

# 2. AWS Provider Configuration

```hcl id="cby3c0"
provider "aws" {
  region = "us-east-1"
}
```

## Purpose

Configures Terraform to deploy resources into AWS.

---

# AWS Region

```text id="8sq7x4"
us-east-1
```

This is the AWS North Virginia region.

---

# 3. Terraform Variable

```hcl id="g9d5d0"
variable "environment" {
  description = "The environment name"
  type        = string
  default     = "dev"
}
```

## Purpose

This variable allows infrastructure naming to change dynamically depending on the deployment environment.

Examples:

* dev
* staging
* production

---

# terraform.tfvars

```hcl id="n1w1j4"
environment = "production"
```

## Explanation

This overrides the default value:

```text id="5l30jv"
dev
```

Terraform will therefore deploy resources using:

```text id="4p5lb4"
production
```

as the environment name.

---

# 4. VPC Resource

```hcl id="p4o0yo"
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name        = "${var.environment}-vpc"
    Environment = var.environment
  }
}
```

## Purpose

Creates a Virtual Private Cloud (VPC).

A VPC is an isolated network environment inside AWS.

---

# VPC Configuration

| Property   | Value          |
| ---------- | -------------- |
| CIDR Block | 10.0.0.0/16    |
| Name Tag   | production-vpc |

---

# Dynamic Naming

Because:

```hcl id="w6frx8"
var.environment
```

equals:

```text id="6ah2y4"
production
```

the VPC name becomes:

```text id="h6xg7k"
production-vpc
```

---

# 5. S3 Bucket Resource

```hcl id="zq7d6t"
resource "aws_s3_bucket" "bucket" {
  bucket = "${var.environment}-bucket"

  tags = {
    Name        = "${var.environment}-bucket"
    Environment = var.environment
  }
}
```

## Purpose

Creates an Amazon S3 bucket for object storage.

---

# S3 Bucket Name

Since:

```text id="vbjlwm"
environment = "production"
```

the bucket name becomes:

```text id="pcz32y"
production-bucket
```

---

# S3 Use Cases

Amazon S3 is commonly used for:

* file storage
* backups
* static websites
* Terraform state storage
* application assets

---

# 6. EC2 Instance Resource

```hcl id="z4b4h1"
resource "aws_instance" "web" {
  ami           = "ami-0c94855ba95c71c99"
  instance_type = "t2.micro"
}
```

## Purpose

Creates a virtual machine (EC2 instance).

---

# EC2 Configuration

| Property      | Value          |
| ------------- | -------------- |
| AMI           | Amazon Linux 2 |
| Instance Type | t2.micro       |

---

# AMI Explanation

AMI stands for:

```text id="6b8k8d"
Amazon Machine Image
```

It acts as a template for launching EC2 instances.

---

# Tags Configuration

All resources use dynamic tags:

```hcl id="2r7cn7"
Environment = var.environment
```

This helps:

* organize infrastructure
* filter resources
* manage environments

---

# Example Generated Names

| Resource     | Generated Name    |
| ------------ | ----------------- |
| VPC          | production-vpc    |
| S3 Bucket    | production-bucket |
| EC2 Instance | production-web    |

---

# 7. Terraform Outputs

Outputs display important information after deployment.

---

## VPC Output

```hcl id="x5c1qe"
output "vpc_id" {
  value = aws_vpc.main.id
}
```

Displays:

* VPC ID

---

## S3 Bucket Output

```hcl id="a4dzy8"
output "bucket_name" {
  value = aws_s3_bucket.bucket.bucket
}
```

Displays:

* S3 bucket name

---

## EC2 Output

```hcl id="7h3z1v"
output "instance_id" {
  value = aws_instance.web.id
}
```

Displays:

* EC2 instance ID

---

# Terraform Concepts Demonstrated

This project demonstrates:

| Concept          | Description                   |
| ---------------- | ----------------------------- |
| Providers        | Connect Terraform to AWS      |
| Variables        | Dynamic infrastructure values |
| Resources        | AWS infrastructure components |
| Outputs          | Display deployment results    |
| Tags             | Resource identification       |
| Parameterization | Reusable infrastructure       |

---

# How to Run This Project

---

# Step 1 — Initialize Terraform

```bash id="yok21u"
terraform init
```

Downloads:

* AWS provider
* Terraform dependencies

---

# Step 2 — Validate Configuration

```bash id="kp4vlh"
terraform validate
```

Checks configuration syntax and logic.

---

# Step 3 — Format Files

```bash id="g08tql"
terraform fmt
```

Formats Terraform code properly.

---

# Step 4 — Generate Execution Plan

```bash id="ru9r7z"
terraform plan
```

Shows what Terraform intends to create.

---

# Step 5 — Apply Infrastructure

```bash id="2lm4lm"
terraform apply
```

Creates AWS resources.

---

# Step 6 — Destroy Infrastructure

```bash id="1a2f5y"
terraform destroy
```

Deletes all created infrastructure.

---

# Expected Outputs After Apply

Example:

```text id="c09wdm"
bucket_name = "production-bucket"
instance_id = "i-xxxxxxxxxxxxx"
vpc_id      = "vpc-xxxxxxxxxxxxx"
```

---

# Security Notes

## S3 Bucket Naming

S3 bucket names must be globally unique.

If deployment fails, modify:

```hcl id="0w5dbz"
bucket = "${var.environment}-bucket"
```

to something more unique:

```hcl id="q0r8h5"
bucket = "production-bucket-12345"
```

# Learning Outcomes

After completing this project, you should understand:

* Terraform basics
* AWS provider configuration
* Terraform variables
* Terraform outputs
* AWS VPC creation
* S3 bucket provisioning
* EC2 provisioning
* Infrastructure parameterization

---

## Author

**NWAMU C. EMMANUEL**

DevOps & Cloud Engineering Enthusiast
