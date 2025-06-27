# CloudWatch Module Outputs

output "lambda_log_group_arn" {
  description = "The ARN of the CloudWatch Log Group for the Lambda visitor counter function"
  value       = aws_cloudwatch_log_group.lambda_log_group.arn
}

output "lambda_log_group_id" {
  description = "The ID of the CloudWatch Log Group for the Lambda visitor counter function"
  value       = aws_cloudwatch_log_group.lambda_log_group.id
}