resource "aws_s3_bucket" "example" {
  bucket = "my-qs-test-bucket"

  tags = {
    Name        = "qs-en-${var.environment}-test-bucket"
    Environment = "development"
  }
}


variable "environment" {
  type    = string
  default = "dev"
}