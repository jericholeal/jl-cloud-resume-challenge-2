# CloudFront Module Outputs

output "jlcrc2_distribution_id" {
  description = "The ID of the CloudFront distribution"
  value       = aws_cloudfront_distribution.jlcrc2_distribution.id
}

output "jlcrc2_distribution_domain_name" {
  description = "The domain name of the CloudFront distribution"
  value       = aws_cloudfront_distribution.jlcrc2_distribution.domain_name
}

output "jlcrc2_oac_id" {
  description = "The ID of the OAC for CloudFront access"
  value = aws_cloudfront_origin_access_control.oac.id
}
