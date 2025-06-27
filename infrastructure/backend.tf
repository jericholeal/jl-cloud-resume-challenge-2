# Terraform backend, state store

terraform {
  backend "s3" {
    bucket = var.terraform_state_bucket_name
    key = "global/s3/terraform.tfstate"
    region = var.aws_region
    encrypt = true
  }
}