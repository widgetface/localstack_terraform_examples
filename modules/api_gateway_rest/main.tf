
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
    ignore_changes        = [tags]
  }

  tags = merge(
    var.additional_tags,
    {
      name        = var.apig_name
      description = var.apig_description
      created     = formatdate("YYYYMMDDhhmmss", timestamp())
    },
  )
}

resource "aws_api_gateway_deployment" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.this.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}

# tfsec:ignore:aws-api-gateway-enable-tracing tfsec:ignore:aws-api-gateway-enable-access-logging
resource "aws_api_gateway_stage" "example" {
  deployment_id = aws_api_gateway_deployment.this.id
  rest_api_id   = aws_api_gateway_rest_api.this.id
  stage_name    = var.stage_name
}