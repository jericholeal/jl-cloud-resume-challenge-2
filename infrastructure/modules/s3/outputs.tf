# S3 Module Outputs

output "jlcrc2_frontend_bucket_domain_name" {
  description = "The domain name of the S3 bucket for the static website"
  value       = aws_s3_bucket.jlcrc2_frontend_bucket.bucket_regional_domain_name
}

output "jlcrc2_frontend_bucket_arn" {
  description = "The ARN of jlcrc2_frontend_bucket"
  value       = aws_s3_bucket.jlcrc2_frontend_bucket.arn
}

output "jlcrc2_frontend_bucket_id" {
  description = "The ID of jlcrc2_frontend_bucket"
  value       = aws_s3_bucket.jlcrc2_frontend_bucket.id
}

output "jlcrc2_lambda_bucket_arn" {
  description = "The ARN of jlcrc2_lambda_bucket"
  value       = aws_s3_bucket.jlcrc2_lambda_bucket.arn
}

output "jlcrc2_lambda_bucket_id" {
  description = "The ID of jlcrc2_lambda_bucket"
  value       = aws_s3_bucket.jlcrc2_lambda_bucket.id
}

output "jlcrc2_frontend_logs_bucket_arn" {
  description = "The ARN of jlcrc2_frontend_logs_bucket"
  value       = aws_s3_bucket.jlcrc2_frontend_logs_bucket.arn
}

output "jlcrc2_frontend_logs_bucket_id" {
  description = "The ID of jlcrc2_frontend_logs_bucket"
  value       = aws_s3_bucket.jlcrc2_frontend_logs_bucket.id
}

output "jlcrc2_terraform_state_bucket_arn" {
  description = "The ARN of jlcrc2_terraform_state_bucket"
  value       = aws_s3_bucket.jlcrc2_terraform_state_bucket.arn
}

output "jlcrc2_terraform_state_bucket_id" {
  description = "The ID of jlcrc2_terraform_state_bucket"
  value       = aws_s3_bucket.jlcrc2_terraform_state_bucket.id
}