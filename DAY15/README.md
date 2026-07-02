<!-- BEGIN_TF_DOCS -->
## Project
 TERRAFORM AWS IAM USER MANAGEMENT MINI PROJECT.

## Overview
This demo demonstrates how to manage AWS IAM users, groups, and group memberships using Terraform and a CSV file as the data source.

## File Structure

```
day15/
├── provider.tf         # AWS provider setup
├── data.tf             # data source for setups
├── main.tf            # User creation and CSV parsing
├── users.csv          # User data source
├── output.tf          # Displays output values
└── README.md          # This file contains comprehensive details of the project
└── users.csv          # This file that contains userdata
```


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.100.0 |


## Resources

| Name | Type |
|------|------|
| [aws_iam_group.education](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group) | resource |
| [aws_iam_group.engineers](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group) | resource |
| [aws_iam_group.managers](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group) | resource |
| [aws_iam_group_membership.education_members](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_membership) | resource |
| [aws_iam_group_membership.engineers_members](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_membership) | resource |
| [aws_iam_group_membership.managers_members](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_membership) | resource |
| [aws_iam_group_policy_attachment.test-attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_user.users](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_login_profile.users](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_login_profile) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_primary_region"></a> [primary\_region](#input\_primary\_region) | Primary AWS region for the first VPC | `string` | `"us-east-1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_user_names"></a> [user\_names](#output\_user\_names) | ================== Output user names ================== |
| <a name="output_user_passwords"></a> [user\_passwords](#output\_user\_passwords) | ===================== Output user\_passwords ===================== |

### Step 1: Read CSV File

The `main.tf` file reads the `users.csv` file:

```terraform
locals {
  users = csvdecode(file("users.csv"))
}
```

### Step 2: Create IAM Users

Users are created with a username format: `{first_initial}{lastname}` (e.g., `mscott`):

```terraform
resource "aws_iam_user" "users" {
  for_each = { for user in local.users : user.first_name => user }
  
  name = lower("${substr(each.value.first_name, 0, 1)}${each.value.last_name}")
  path = "/users/"
  
  tags = {
    "DisplayName" = "${each.value.first_name} ${each.value.last_name}"
    "Department"  = each.value.department
    "JobTitle"    = each.value.job_title
  }
}
```

### Step 3: Enable Console Access

Login profiles are created for console access with password reset required:

```terraform
resource "aws_iam_user_login_profile" "users" {
  for_each = aws_iam_user.users
  
  user                    = each.value.name
  password_reset_required = true
}
```

### Step 4: Create Groups and Memberships

Groups are created and users are dynamically assigned based on their department and attach policy:

```terraform
resource "aws_iam_group" "education" {
  name = "Education"
  path = "/groups/"
}

resource "aws_iam_group_membership" "education_members" {
  name  = "education-group-membership"
  group = aws_iam_group.education.name
  
  users = [
    for user in aws_iam_user.users : user.name 
    if user.tags.Department == "Education"
  ]
}


resource "aws_iam_group_policy_attachment" "test-attach" {
  group      = aws_iam_group.education.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}
```

## Outputs

After applying, you can view the outputs:

```powershell
# View AWS Account ID
terraform output account_id

# View all user names
terraform output user_names

# View password information (sensitive)
terraform output user_passwords
```

## User List

The following users are created from `users.csv`:

| Username | Full Name | Department | Job Title |
|----------|-----------|------------|-----------|
| mscott | Michael Scott | Education | Regional Manager |
| dschrute | Dwight Schrute | Sales | Assistant to the Regional Manager |
| jhalpert | Jim Halpert | Sales | Sales Representative |
| pbeesly | Pam Beesly | Reception | Receptionist |
| rhoward | Ryan Howard | Temps | Temp |
| ... and 21 more users |

## Groups and Memberships

### Education Group
- Michael Scott (mscott)

### Managers Group
Users with "Manager" or "CEO" in their job title:
- Michael Scott (mscott)
- Robert California (rcalifornia)
- Darryl Philbin (dphilbin)
- David Wallace (dwallace)
- Jo Bennett (jbennett)

### Engineers Group
- Currently empty (no users with "Engineering" department in CSV)

## Customization

### Add More Users

Edit `users.csv` and add new rows:

```csv
first_name,last_name,department,job_title
Jane,Doe,Engineering,Software Engineer
```

Then run:

```powershell
terraform apply
```

### Add IAM Policies to Groups

Add to `groups.tf`:

```terraform
resource "aws_iam_group_policy_attachment" "education_readonly" {
  group      = aws_iam_group.education.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}
```

### Change Username Format

Modify the `name` attribute in `main.tf`:

```terraform
# Current: {first_initial}{lastname} (e.g., mscott)
name = lower("${substr(each.value.first_name, 0, 1)}${each.value.last_name}")

# Alternative: {firstname}.{lastname} (e.g., michael.scott)
name = lower("${each.value.first_name}.${each.value.last_name}")
```

## Password Management

AWS doesn't return auto-generated passwords without PGP encryption. To set passwords:

### Option 1: AWS Console
1. Go to IAM Console
2. Select a user
3. Click "Security credentials"
4. Click "Enable console access" or "Manage console access"
5. Set a password

### Option 2: AWS CLI

```powershell
aws iam create-login-profile --user-name mscott --password "TempPassword123!" --password-reset-required
```

## Best Practices

✅ **Use Remote State** - S3 backend with versioning enabled  
✅ **Consistent Naming** - Lowercase usernames with predictable format  
✅ **Metadata as Tags** - Store user attributes as searchable tags  
✅ **Password Reset** - Force password change on first login  
✅ **Data-Driven** - CSV file as single source of truth  
✅ **Idempotent** - Safe to run multiple times  

## Security Considerations

⚠️ **Important:**
- Users require password reset on first login
- Consider implementing MFA requirements
- Review IAM policies before attaching to groups
- Don't commit `terraform.tfstate` to version control
- Use AWS SSO for production environments
- Enable CloudTrail for audit logging


## 🚀 Deployment Guide
To deploy this infrastructure, follow the standard Terraform workflow:

1.  **Initialize**: `terraform init` (Initializes the S3 backend and downloads the AWS provider).
2.  **Validate**: `terraform validate` (Ensures configuration syntax is correct).
3.  **Plan**: `terraform plan` (Generates an execution plan to preview changes).
4.  **Apply**: `terraform apply` (Executes the plan to provision resources).
4.  **Destroy**: `terraform destroy` (Destroys provisioned resources).



## Best Practices

✅ **Use Remote State** - S3 backend with versioning enabled  
✅ **Consistent Naming** - Lowercase usernames with predictable format  
✅ **Metadata as Tags** - Store user attributes as searchable tags  
✅ **Password Reset** - Force password change on first login  
✅ **Data-Driven** - CSV file as single source of truth  
✅ **Idempotent** - Safe to run multiple times  


## Author

**NWAMU C. EMMANUEL**

DevOps & Cloud Engineering Enthusiast

<!-- END_TF_DOCS -->