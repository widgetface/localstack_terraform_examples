resource "aws_s3_bucket" "new-bucket" {
  bucket = "new-bucket"
  tags = {
    Name        = "Test bucket"
    Environment = "Staging"
  }
}