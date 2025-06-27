# Lambda Module Outputs

output "jlcrc2_lambda_exec_role_name" {
  description = "The name of the Lambda execution role"
  value       = aws_iam_role.jlcrc2_lambda_exec.name
}

output "jlcrc2_lambda_exec_role_arn" {
  description = "The ARN of the Lambda execution role"
  value       = aws_iam_role.jlcrc2_lambda_exec.arn
}

output "jlcrc2_lambda_exec_policy_name" {
  description = "The name of the Lambda execution policy"
  value       = aws_iam_role_policy.jlcrc2_lambda_policy.name
}


output "jlcrc2_visitor_counter_function_name" {
  description = "The name of the Lambda function for visitor counter"
  value       = aws_lambda_function.jlcrc2_visitor_counter_function.function_name
}

output "jlcrc2_visitor_counter_function_arn" {
  description = "The ARN of the Lambda function for visitor counter"
  value       = aws_lambda_function.jlcrc2_visitor_counter_function.arn
}

output "jlcrc2_visitor_counter_function_id" {
  description = "The ID of the Lambda function for visitor counter"
  value       = aws_lambda_function.jlcrc2_visitor_counter_function.id
}