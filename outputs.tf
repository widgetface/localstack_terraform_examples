# Detect if Terraform configuration 
# is deployed against LocalStack,
data "aws_caller_identity" "current" {}
output "is_localstack" {
  value = data.aws_caller_identity.current.id == "000000000000"
}


