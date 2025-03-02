# Terraform Workspaces Example

This example demonstrates how to use Terraform workspaces to manage multiple environments (e.g., development, staging, production) using the same configuration. Workspaces provide isolated state management, allowing for consistent infrastructure deployments across different environments.

## Folder Structure

```
Example-3/
├── main.tf
├── terraform.tfvars
├── modules/
│   ├── ec2_instance/
│   │   ├── main.tf
└── README.md
```

- **`main.tf`**: Defines the Terraform provider and resources.
- **`terraform.tfvars`**: Contains variable values for configuration customization.
- **`modules/ec2_instance/main.tf`**: Defines the EC2 instance module.
- **`README.md`**: Documentation for this project.

## Terraform Workspaces

Terraform workspaces enable separate state files for different environments, preventing conflicts and ensuring isolation.

### Creating and Switching Workspaces

To create a new workspace:

```bash
terraform workspace new <workspace_name>
```

Example:
```bash
terraform workspace new development
```

To switch between workspaces:
```bash
terraform workspace select <workspace_name>
```

Example:
```bash
terraform workspace select production
```

### Listing Workspaces
To view all available workspaces:
```bash
terraform workspace list
```

The current workspace is marked with an asterisk (*).

## Usage

1. **Initialize Terraform**
   ```bash
   terraform init
   ```
2. **Create or Select a Workspace**
   ```bash
   terraform workspace new development
   ```
   or
   ```bash
   terraform workspace select development
   ```
3. **Plan Deployment**
   ```bash
   terraform plan
   ```
4. **Apply Changes**
   ```bash
   terraform apply
   ```
5. **Destroy Infrastructure**
   ```bash
   terraform destroy
   ```

For further details, refer to the [Terraform CLI Workspaces documentation](https://developer.hashicorp.com/terraform/cli/workspaces).

