output "api_id" {
  value = aws_api_gateway_rest_api.this.id
}

output "api_name" {
  value = aws_api_gateway_rest_api.this.name
}

output "api_description" {
  value = aws_api_gateway_rest_api.this.description
}

output "root_resource_id" {
  value = aws_api_gateway_rest_api.this.root_resource_id
}
