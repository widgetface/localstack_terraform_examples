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
