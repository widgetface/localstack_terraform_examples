# tfsec:ignore:aws-s3-enable-bucket-encryption tfsec:ignore:aws-s3-encryption-customer-key
resource "aws_s3_bucket" "upload_bucket" {
  bucket_prefix = var.s3_bucket_prefix
  tags = merge(
    var.additional_tags.bucket_tags,
    {
      prefix  = var.s3_bucket_prefix
      created = formatdate("YYYYMMDDhhmmss", timestamp())
    },
  )
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.upload_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.upload_bucket.id
  restrict_public_buckets = true
  ignore_public_acls      = true
  block_public_acls       = true
  block_public_policy     = true
}

resource "aws_s3_object" "this" {
  bucket       = aws_s3_bucket.upload_bucket.id
  for_each     = fileset(var.fileset_path, var.fileset_pattern)
  key          = "openapi-${each.value}"
  source       = "${var.fileset_path}/${each.value}"
  content_type = each.value
  tags = merge(
    var.additional_tags.bucket_object_tags,
    {
      created = formatdate("YYYYMMDDhhmmss", timestamp())
      type    = "uploaded file"
    },
  )
  metadata = var.s3_object_metadata
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.upload_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  bucket = aws_s3_bucket.upload_bucket.id

  rule {
    id     = "transition_none_current-to_glacier_ir"
    status = "Enabled"

    filter {}
    noncurrent_version_transition {
      noncurrent_days = 5
      storage_class   = "GLACIER_IR"
    }
  }
}

#tfsec:ignore:aws-s3-enable-bucket-encryption tfsec:ignore:aws-s3-enable-bucket-logging tfsec:ignore:aws-s3-enable-versioning
resource "aws_s3_bucket" "log_bucket" {
  bucket = "${aws_s3_bucket.upload_bucket.bucket_prefix}-logging"
}

resource "aws_s3_bucket_acl" "log_bucket_acl" {
  bucket = aws_s3_bucket.log_bucket.id
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket_public_access_block" "logging_access_block" {
  bucket                  = aws_s3_bucket.log_bucket.id
  restrict_public_buckets = true
  ignore_public_acls      = true
  block_public_acls       = true
  block_public_policy     = true
}


resource "aws_s3_bucket_logging" "this" {
  bucket = aws_s3_bucket.upload_bucket.id

  target_bucket = aws_s3_bucket.log_bucket.id
  target_prefix = "log/"
}

