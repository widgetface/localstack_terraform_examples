variable "apig_name" {
  description = "Name of api gateway"
  type        = string
}

variable "apig_types" {
  description = "Type of api gateway"
  type        = string
  default     = "REGIONAL"
  validation {
    condition     = contains(["REGIONAL", "EDGE", "PRIVATE"], var.apig_types)
    error_message = "Invalid API Gateway type value allowed values are : 'REGIONAL', 'EDGE' or  'PRIVATE'"
  }
}

variable "apig_description" {
  description = "Description of api gateway"
  type        = string
  validation {
    condition     = var.apig_description != null && length(var.apig_description) > 0
    error_message = "The string cannot be null or empty."
  }
}

variable "file_path" {
  description = "Path to OpenAPI specification"
  type        = string
  validation {
    condition     = var.file_path != null
    error_message = "The string cannot be null and must use semantic versioning"
  }
}
# tflint-ignore: terraform_unused_declarations
variable "api_gateway_url" {
  description = "API Gateway url"
  type        = string
  default     = null
}

variable "stage_name" {
  description = "Region used"
  type        = string
}

variable "lambda_function_arn" {
  description = "Lambda role arn"
  type        = string
}

variable "lambda_role_arn" {
  description = "Lambda role arn"
  type        = string
}

variable "region" {
  description = "Region used"
  type        = string
  default     = "us-east-1"
}
variable "additional_tags" {
  default     = {}
  description = "Additional resource tags"
  type        = map(string)
}
