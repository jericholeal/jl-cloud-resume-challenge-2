aws_region   = "us-east-1"
aws_profile  = "cr-challenge2"
project_name = "jlcrc2"

# S3
frontend_s3_bucket_name     = "jlcrc2-frontend"
lambda_s3_bucket_name       = "jlcrc2-lambda"
logs_s3_bucket_name         = "jlcrc2-logs"
terraform_state_bucket_name = "jlcrc2-terraform-state"

# Lambda
lambda_s3_key           = "jlcrc2_visitor_counter.zip"
lambda_function_name    = "jlcrc2_visitor_counter"
lambda_exec_role_name   = "jlcrc2-lambda-exec-role"
lambda_exec_policy_name = "jlcrc2-visitor-counter-exec-policy"

# DynamoDB
dynamodb_table_name                = "jlcrc2-visitor-counter"
dynamodb_table_partition_key       = "pk"
dynamodb_table_partition_value     = "visitorCounter"
dynamodb_table_counter_attribute   = "visitCount"
dynamodb_terraform_lock_table_name = "jlcrc2-terraform-lock"

# Route53
jlcrc2_domain_name = "jlcrc.cloud"

# CloudWatch
lambda_log_retention_in_days = 14

# OIDC
github_oidc_backend_deploy_role_name  = "github-crc2-backend-deploy"
github_oidc_frontend_deploy_role_name = "github-crc2-frontend-deploy"
github_username                       = "jericholeal"
github_repo_name                      = "jl-cloud-resume-challenge-2"
