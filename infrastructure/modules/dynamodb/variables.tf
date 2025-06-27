# DynamoDB Module Variables

variable "project_name" {
  description = "Name of the project for resource tagging"
  type        = string
}

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
  description = "Name of DynamoDB table for Terraform lock"
  type        = string
}
