resource "aws_s3_bucket" "qovery-erebe-test" {
  bucket = var.bucket_name

  tags = {
    Name        = "erebe-test"
    Environment = "Dev"
  }
}

