# Variables

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "aws_profile" {
  description = "AWS CLI profile to use for authentication"
  type        = string
}

variable "project_name" {
  description = "Name of the project for resource tagging"
  type        = string
}

# S3

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

# Lambda

variable "lambda_s3_key" {
  description = "S3 key for Lambda function code"
  type        = string
}

variable "lambda_function_name" {
  description = "Name of Lambda function for visitor counter"
  type        = string
}

variable "lambda_exec_role_name" {
  description = "Name of the Lambda execution role"
  type        = string
}

variable "lambda_exec_policy_name" {
  description = "Name of the Lambda execution policy"
  type        = string
}

# DynamoDB

variable "dynamodb_table_name" {
  description = "Name of DynamoDB table for visitor counter"
  type        = string
}

variable "dynamodb_table_partition_key" {
  description = "DynamoDB table partition key"
  type        = string
}

variable "dynamodb_table_partition_value" {
  description = "DynamoDB table partition value"
  type        = string
}

variable "dynamodb_table_counter_attribute" {
  description = "DynamoDB table counter attribute"
  type        = string
}

variable "dynamodb_terraform_lock_table_name" {
  description = "Name for Terraform lock DynamoDB table"
  type        = string
}

# Route53

variable "jlcrc2_domain_name" {
  description = "Domain name for the Route 53 hosted zone and records"
  type        = string
}

# CloudFront

variable "jlcrc2_s3_origin_id" {
  description = "The origin ID for the S3 bucket in CloudFront"
  type        = string
}

# CloudWatch

variable "lambda_log_retention_in_days" {
  description = "The number of days to retain logs for the Lambda function"
  type        = number
}

# GitHub OIDC

variable "github_oidc_backend_deploy_role_name" {
  description = "Name of the IAM role for GitHub OIDC"
  type        = string
}

variable "github_oidc_frontend_deploy_role_name" {
  description = "Name of the IAM role for GitHub OIDC frontend deployment"
  type        = string
}

variable "github_username" {
  description = "GitHub username for OIDC role"
  type        = string
}

variable "github_repo_name" {
  description = "GitHub repository name for OIDC role"
  type        = string
}