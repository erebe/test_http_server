resource "aws_s3_bucket" "qovery-erebe-test" {
  bucket = "qovery-erebe-test"

  tags = {
    Name        = "erebe-test"
    Environment = "Dev"
  }
}

