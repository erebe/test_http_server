resource "aws_s3_bucket" "qovery_s3_test" {
  bucket = var.bucket_name

  tags = {
    Name        = "erebe-test"
    Environment = "Dev"
  }
}

resource "local_file" "qovery_export_to_env_var" {
  filename = "/qovery-output/qovery-output.json"
  content  = jsonencode({
    "BUCKET_ARN" = { "value" = qovery_s3_test.arn, "sensitive" = false },
    "BUCKET_DOMAIN_NAME" = { "value" = qovery_s3_test.bucket_domain_name, "sensitive" = true },
  })
}
