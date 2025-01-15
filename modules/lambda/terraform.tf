terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.83.0"
    }
    template = {
      source  = "hashicorp/template"
      version = "~> 2"
    }
  }
  required_version = "~> 1.10.3"
} 