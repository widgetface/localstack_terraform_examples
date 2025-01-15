
variable "s3_bucket_prefix" {
  description = "Prefix of S3 bucket, usually the proect name"
  type        = string
  validation {
    condition     = var.s3_bucket_prefix != null && length(var.s3_bucket_prefix) > 0
    error_message = "The string cannot be null or empty."
  }
}

variable "s3_object_metadata" {
  description = "file metadata"
  type        = map(string)
  default     = {}
}

variable "fileset_path" {
  description = "Path to folder containing files to upload into S3 bucket"
  type        = string
}

variable "fileset_pattern" {
  description = "Pattern matcher (terraform fileset files reg ex) for files to be uploaded"
  type        = string
  default     = "**/*.json"
}

variable "additional_tags" {
  description = "Additional resource tags"
  type        = map(map(string))
  default = {
    bucket_tags : {
      access    = "private"
      type      = "upload"
      versioned = "true"
    }
    bucket_object_tags : {
      versioned = "true"
    }

  }
}
