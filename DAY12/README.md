<!-- BEGIN_TF_DOCS -->
#  Terraform Data Sources with AWS

## Overview

This demonstrates how to use Terraform data sources to reference existing infrastructure in AWS. I will provision an EC2 instance into a pre-existing VPC and subnet.


## 🏗️ File Structure
The infrastructure is modularized into several key files to ensure maintainability and separation of concerns:

* **`main.tf`**: Contains the core resource definitions for AWS. 
* **`variable.tf`**: Centralizes all input variables, showcasing a wide range of Terraform datatypes.
* **`providers.tf`**: Configures the required AWS provider and version constraints for consistency.
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
| [aws_instance.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_ami.amazon_linux_2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_subnet.nuelcruz](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_vpc.nuel](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"us-east-1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | n/a |
| <a name="output_instance_private_ip"></a> [instance\_private\_ip](#output\_instance\_private\_ip) | n/a |
| <a name="output_nuel_default"></a> [nuel\_default](#output\_nuel\_default) | n/a |


## Scenario

We have a "shared" VPC and subnet that were created by another team or process. Our task is to launch a new EC2 instance into this existing network infrastructure without managing the VPC or subnet with our Terraform configuration.

### Pre-existing Infrastructure

The following resources are assumed to exist in your AWS account:

*   **VPC:** with the tag `Name` = `shared-network-vpc`
*   **Subnet:** with the tag `Name` = `shared-primary-subnet`

### Terraform Configuration (`main.tf`)

Our Terraform code will:

1.  **Define Data Sources:**
    *   `data "aws_vpc" "shared"`: This block tells Terraform to find a VPC with the tag `Name` set to `shared-network-vpc`.
    *   `data "aws_subnet" "shared"`: This block finds a subnet with the tag `Name` set to `shared-primary-subnet` within the VPC found by the previous data source.
    *   `data "aws_ami" "amazon_linux_2"`: This block finds the latest Amazon Linux 2 AMI to use for our EC2 instance.

2.  **Use Data Source Outputs:**
    *   The `aws_instance` resource uses `data.aws_subnet.shared.id` to launch into the existing subnet.
    *   The `aws_instance` resource also uses `data.aws_ami.amazon_linux_2.id` for the AMI.

## How to Run This Demo

### 1. Create the Pre-existing Infrastructure

First, we need to simulate the creation of the shared network resources.

```bash
cd lessons/day13/code/setup
terraform init
terraform apply
```

This will create a VPC and a subnet.

### 2. Provision the EC2 Instance

Now, we'll run the main Terraform configuration that uses data sources.

```bash
cd ../.. # Go back to the day13/code directory
terraform init
terraform plan
```

**Expected Plan Output:** The plan should show that Terraform will create **1 new resource**: an `aws_instance`. It should **not** show any changes to the VPC or subnet.

```bash
terraform apply
```

### 3. Verification

1.  Go to the AWS EC2 console.
2.  Find the instance named `day13-instance`.
3.  Check its "Networking" details. You will see that it is in the `shared-network-vpc` and `shared-primary-subnet`, confirming that the data sources worked correctly.

### 4. Cleanup

To destroy the resources created in this lesson:

```bash
# Destroy the instance
cd lessons/day13/code
terraform destroy

# Destroy the shared VPC and subnet
cd setup
terraform destroy
```


## Author

**NWAMU C. EMMANUEL**

DevOps & Cloud Engineering Enthusiast

<!-- END_TF_DOCS -->