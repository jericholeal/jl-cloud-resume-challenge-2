# Terraform backend, state store

terraform {
  backend "s3" {
    bucket         = "jlcrc2-terraform-state"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    use_lock_table = true
  }
}