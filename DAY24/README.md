# : Harshicorp Cloud Platform and Workspaces..
HCP Terraform is a managed cloud platform that helps teams use Terraform without having to run everything from their local machine.
With regular Terraform CLI, you run commands like:

terraform init
terraform plan
terraform apply

on your laptop or a server.

With HCP Terraform, your Terraform code is stored in a Git repository, and the planning and deployment happen in HashiCorp's cloud environment instead of on your local machine.

| Feature            | Terraform CLI       | HCP Terraform     |
| ------------------ | ------------------- | ----------------- |
| Runs on            | Local machine       | HashiCorp cloud   |
| State storage      | Usually local or S3 | Managed remotely  |
| Team collaboration | Manual              | Built-in          |
| Access control     | Limited             | Role-based access |
| Audit logs         | Manual              | Built-in          |
| CI/CD integration  | You build it        | Native support    |
| Policy enforcement | Manual              | Built-in          |
| Cost estimation    | No                  | Yes               |
| Drift detection    | Manual              | Automated         |
