output "bucket_name" {
  value       = aws_s3_bucket.upload_bucket.bucket
  description = "The name of the S3 bucket"
}

output "s3_bucket_id" {
  description = "The id of the bucket."
  value       = aws_s3_bucket.upload_bucket.id
}

output "bucket_arn" {
  value       = aws_s3_bucket.upload_bucket.arn
  description = "The ARN of the S3 bucket"
}

output "bucket_region" {
  value       = aws_s3_bucket.upload_bucket.region
  description = "The AWS region where the bucket is located"
}

output "bucket_creation_date" {
  value       = formatdate("YYYYMMDD", timestamp())
  description = "The creation date of the S3 bucket"
}

output "bucket_acl" {
  value       = aws_s3_bucket.upload_bucket.acl
  description = "The access control list of the S3 bucket"
}

output "bucket_domain_name" {
  value       = aws_s3_bucket.upload_bucket.bucket_domain_name
  description = "The domain name of the S3 bucket"
}

output "s3_bucket_lifecycle_configuration_rules" {
  description = "The lifecycle rules of the bucket, if the bucket is configured with lifecycle rules. If not, this will be an empty string."
  value       = aws_s3_bucket_lifecycle_configuration.this.rule
}