variable "lambda_function_name" {
  description = "Name of lambda, should contain the project name"
  type        = string
}

variable "lambda_handler" {
  description = "entry point for lambda code"
  type        = string
  default     = "index.lambda_handler"
}

variable "lambda_runtime" {
  description = "Runtime for lambda"
  type        = string
  default     = "python3.9"
}

variable "file_output_path" {
  description = "Path for zip of code for lambda"
  type        = string
}

variable "file_source_path" {
  description = "Path for source code for lambda"
  type        = string
}

variable "additional_variables" {
  description = "Additional varaibles for lambda"
  type        = map(string)
  default     = null
}



