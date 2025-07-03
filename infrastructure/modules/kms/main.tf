# KMS Module Configuration

resource "aws_kms_key" "jlcrc2_dnssec_signing_key" {
  description = "DNSSEC signing key for ${var.jlcrc2_domain_name}"
  key_usage = "SIGN_VERIFY"
  customer_master_key_spec = "ECC_NIST_P256" # for DNSSEC
  deletion_window_in_days = var.deletion_window_in_days

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "Allow administration of the key"
        Effect = "Allow"
        Principal = {
          AWS = var.kms_key_admin_arns
        }
        Action = [
          "kms:*"
        ]
        Resource = "*"
      },
      {
        Sid = "Allow Route53 DNSSEC usage"
        Effect = "Allow"
        Principal = {
          Service = "dnssec-route53.amazonaws.com"
        }
        Action = [
          "kms:Sign",
          "kms:Verify"
        ]
        Resource = "*"
      }
    ]
  })
}