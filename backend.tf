terraform {
  backend "s3" {
#    access_key = "{{ aws_access_key_tfstates_account }}"
#    secret_key = "{{ aws_secret_key_tfstates_account }}"
#    region = "{{ aws_region_tfstates_account }}"
#    bucket = "qovery-test-terrafom-tfstates"
    key = "erebe.tfstate"
    dynamodb_table = "qovery-terrafom-tfstates"
  }
}


