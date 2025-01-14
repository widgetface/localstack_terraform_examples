# localstack_terraform_examples

## Pre-requisities
1. Install localstack see [Localstack](https://app.localstack.cloud/getting-started)
2. If manual locastack configuration is NOT used then you need to have Python installed and use the tflocal package as described in the [Documentation](https://docs.localstack.cloud/user-guide/integrations/terraform/#tflocal-wrapper-script)

### Notes:
> These examples use manual setting for localstack
> I'm using WSL2/Windows 11.
> Im using AWS (via localstack)

### Using localstack to prepare for Terraform certification

### Get started
#### branch: base_example
1. Run terraform init
2. Run Terraform plan or apply

### branch: modules
Develop modules for use in projects
Using pre-commit hooks