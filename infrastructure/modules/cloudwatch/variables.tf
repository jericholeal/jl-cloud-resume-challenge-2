# CloudWatch Module Variables

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "lambda_function_name" {
  description = "The name of the Lambda function"
  type        = string
}

variable "lambda_log_retention_in_days" {
  description = "The number of days to retain logs for the Lambda function"
  type        = number
}