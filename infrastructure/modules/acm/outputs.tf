# ACM Module Outputs

output "acm_certificate_arn" {
  description = "The ARN of the ACM certificate"
  value       = aws_acm_certificate.jlcrc2_cert.arn
}

output "acm_certificate_id" {
  description = "The ID of the ACM certificate"
  value       = aws_acm_certificate.jlcrc2_cert.id
}