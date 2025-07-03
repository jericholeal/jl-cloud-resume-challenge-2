# KMS Module Variables

variable "jlcrc2_domain_name" {
    description = "Name of jlcrc2 domain"
    type        = string
}

variable "deletion_window_in_days" {
    description = "KMS key deletion window in days"
    type        = string
}

variable "kms_key_admin_arns" {
    description = "List of ARNs that administer key"
    type        = list(string)
}