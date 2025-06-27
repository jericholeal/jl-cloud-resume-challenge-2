# CloudFront Module Variables

variable "project_name" {
  description = "Name of the project, used for tagging/naming"
  type        = string

}
variable "jlcrc2_frontend_bucket" {
  description = "Name of the S3 bucket for the static website"
  type        = string
}

variable "acm_certificate_arn" {
  description = "ARN of the ACM certificate for CloudFront"
  type        = string
}

variable "account_id" {
  description = "AWS account ID for the CloudFront distribution"
  type        = string
}

variable "jlcrc2_s3_origin_id" {
  description = "The origin ID for the S3 bucket in CloudFront"
  type        = string
}

variable "jlcrc2_frontend_bucket_domain_name" {
  description = "Domain name of the S3 bucket for the frontend"
  type        = string
}

variable "frontend_logs_s3_bucket_name" {
  description = "Name of the S3 bucket for frontend logs"
  type        = string
}