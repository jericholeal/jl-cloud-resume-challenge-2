# S3 Module Variables

variable "project_name" {
  description = "Name of the project for resource tagging"
  type        = string
}

variable "account_id" {
  description = "AWS account ID for the S3 bucket"
  type        = string
}

variable "frontend_s3_bucket_name" {
  description = "Name of the S3 bucket for the frontend"
  type        = string
}

variable "lambda_s3_bucket_name" {
  description = "S3 bucket for Lambda zip"
  type        = string
}

variable "frontend_logs_s3_bucket_name" {
  description = "S3 bucket for frontend logs"
  type        = string
}

variable "terraform_state_bucket_name" {
  description = "S3 bucket for remote Terraform state storage"
  type        = string
}

variable "jlcrc2_lambda_exec_role_arn" {
  description = "ARN of the Lambda execution role"
  type        = string
}

variable "jlcrc2_oac_id" {
  description = "ID of the OAC for CloudFront access"
  type        = string
}