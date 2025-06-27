# ACM Module Variables

variable "jlcrc2_route53_zone_id" {
  description = "The ID of the Route 53 hosted zone to use for DNS validation"
  type        = string
}

variable "jlcrc2_domain_name" {
  description = "The domain name for the ACM certificate"
  type        = string
}

variable "jlcrc2_cert_validation_arn" {
  description = "The ARN of the ACM certificate validation resource"
  type        = string
}