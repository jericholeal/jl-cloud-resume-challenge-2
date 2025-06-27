# API Gateway Module Variables

variable "aws_region" {
  description = "AWS region where the API Gateway will be created"
  type        = string
}

variable "jlcrc2_visitor_counter_function_arn" {
  description = "The ARN of the Lambda function for visitor counter"
  type        = string
}

variable "lambda_function_name" {
  description = "Name of the Lambda function for visitor counter"
  type        = string
}