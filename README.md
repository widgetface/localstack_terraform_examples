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
Using pre-commit hooks to enable terraform fmt, lint, validate and tfSec checking of commited code.
This branch contains a simple application consisting of
API gateway and a Lambda function
The API gateway is provsioned using an OpenAPI specification
Lambda is intergrated into the OpenAPI spec using the x-amazon-apigateway-integration OpenAI extension.

To test the APIGateway get the API id from the Localstack resource browser, path and stage details and use:

http://localhost:4566/_aws/execute-api/apiId/stageName/path
