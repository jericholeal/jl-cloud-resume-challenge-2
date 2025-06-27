# OIDC Module Variables

variable "project_name" {
  type = string
}

variable "account_id" {
  description = "AWS account ID for resource tagging"
  type        = string
}

variable "github_oidc_backend_deploy_role_name" {
  description = "Name of the OIDC role for GitHub Actions"
  type        = string
}

variable "github_oidc_frontend_deploy_role_name" {
  description = "Name of the OIDC role for GitHub Actions frontend deployment"
  type        = string
}

variable "github_username" {
  description = "GitHub username for OIDC role"
  type        = string
}

variable "github_repo_name" {
  description = "GitHub repository name for OIDC role"
  type        = string
}

variable "frontend_s3_bucket_name" {
  description = "S3 bucket name for the frontend deployment"
  type        = string
}

variable "frontend_logs_s3_bucket_name" {
  description = "S3 bucket name for frontend logs"
  type        = string
}