resource "aws_s3_bucket" "qovery_s3_test" {
  bucket = var.bucket_name

  tags = {
    Name        = "erebe-test"
    Environment = "Dev"
  }
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.qovery_s3_test.arn
  description = "bucket_arn_description"
}

output "s3_bucket_domain_name" {
   value = aws_s3_bucket.qovery_s3_test.bucket_domain_name
   sensitive = true
   description = "s3_bucket_domain_name_description"
}
