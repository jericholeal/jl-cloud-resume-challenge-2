# DynamoDB Module Outputs

output "jlcrc2_visitor_counter_table_arn" {
  description = "The ARN of the DynamoDB table for visitor counter"
  value       = aws_dynamodb_table.jlcrc2_visitor_counter_table.arn
}

output "jlcrc2_visitor_counter_table_id" {
  description = "The ID of the DynamoDB table for visitor counter"
  value       = aws_dynamodb_table.jlcrc2_visitor_counter_table.id
}