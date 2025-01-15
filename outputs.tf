# Detect if Terraform configuration 
# is deployed against LocalStack,
data "aws_caller_identity" "current" {}
output "is_localstack" {
  value = data.aws_caller_identity.current.id == "000000000000"
}

output "api_gateway_url" {
  value = module.apig.api_gateway_url
}
