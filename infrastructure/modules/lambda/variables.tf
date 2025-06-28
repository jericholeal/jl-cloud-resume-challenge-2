# Lambda Module Variables

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "lambda_execution_logs_arn" {
  description = "ARN of the CloudWatch Logs group for Lambda execution logs"
  type        = string
}

variable "jlcrc2_dynamodb_table_arn" {
  description = "ARN of the DynamoDB table used by the Lambda function"
  type        = string
}

variable "lambda_function_name" {
  description = "Name of the Lambda function"
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

variable "lambda_s3_bucket" {
  description = "S3 bucket where the Lambda function code is stored"
  type        = string
}

variable "lambda_s3_key" {
  description = "S3 key for the Lambda function code"
  type        = string
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table used by the Lambda function"
  type        = string
}

variable "dynamodb_table_partition_key" {
  description = "Partition key for the DynamoDB table"
  type        = string
}

variable "dynamodb_table_partition_value" {
  description = "Partition value for the DynamoDB table"
  type        = string
}

variable "dynamodb_counter_attribute" {
  description = "Counter attribute for the DynamoDB table"
  type        = string
}