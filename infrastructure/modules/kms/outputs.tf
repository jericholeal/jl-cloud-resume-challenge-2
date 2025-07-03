# KMS Module Outputs

output "jlcrc2_kms_key_id" {
  description = "KMS key ID"
  value = aws_kms_key.jlcrc2_dnssec_signing_key.key_id
}

output "jlcrc2_kms_key_arn" {
  description = "KMS key ARN"
  value = aws_kms_key.jlcrc2_dnssec_signing_key.arn
}