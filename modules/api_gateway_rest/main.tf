
# Manages an API Gateway REST API. 
# The REST API is configured via importing an OpenAPI specification
# in the body argument 

resource "aws_api_gateway_rest_api" "this" {
  name        = var.apig_name
  description = var.apig_description
  body        = file(var.file_path)
  endpoint_configuration {
    types = [var.apig_types]
  }
  lifecycle {
    create_before_destroy = true
  }
}