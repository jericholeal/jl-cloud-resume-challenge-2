# Route53 Module Variables

variable "project_name" {
  description = "The name of the project for tagging resources"
  type        = string
}

variable "jlcrc2_domain_name" {
  description = "The domain name for the Route 53 hosted zone and records"
  type        = string
}

variable "jlcrc2_distribution_domain_name" {
  description = "The domain name of the CloudFront distribution"
  type        = string
}

variable "jlcrc2_dnssec_ksk_name" {
  description = "Name of jlcrc2 DNSSEC key signing key"
  type        = string
}

variable "jlcrc2_kms_key_arn" {
  description = "ARM of the jlcrc2 KMS key"
  type        = string
}