module "acm" {
  source = "./modules/acm"

  jlcrc2_domain_name         = var.jlcrc2_domain_name
  jlcrc2_route53_zone_id     = module.route53.jlcrc2_route53_zone_id
  jlcrc2_cert_validation_arn = local.jlcrc2_cert_validation_arn
}

module "apigateway" {
  source = "./modules/apigateway"

  aws_region                          = var.aws_region
  jlcrc2_visitor_counter_function_arn = module.lambda.jlcrc2_visitor_counter_function_arn
  lambda_function_name                = var.lambda_function_name
}

module "cloudfront" {
  source = "./modules/cloudfront"

  project_name                       = var.project_name
  account_id                         = local.account_id
  acm_certificate_arn                = module.acm.certificate_arn
  jlcrc2_frontend_bucket             = var.frontend_s3_bucket_name
  jlcrc2_s3_origin_id                = module.s3.jlcrc2_s3_origin_id
  jlcrc2_frontend_bucket_domain_name = module.s3.jlcrc2_frontend_bucket_domain_name
  frontend_logs_s3_bucket_name       = var.frontend_logs_s3_bucket_name
}

module "cloudwatch" {
  source = "./modules/cloudwatch"

  lambda_function_name         = var.lambda_function_name
  lambda_log_retention_in_days = var.lambda_log_retention_in_days
  project_name                 = var.project_name
}

module "dynamodb" {
  source = "./modules/dynamodb"

  project_name                     = var.project_name
  dynamodb_table_name              = var.dynamodb_table_name
  dynamodb_table_partition_key     = var.dynamodb_table_partition_key
  dynamodb_table_partition_value   = var.dynamodb_table_partition_value
  dynamodb_table_counter_attribute = var.dynamodb_table_counter_attribute
}

module "lambda" {
  source = "./modules/lambda"

  project_name                   = var.project_name
  lambda_execution_logs_arn      = module.cloudwatch.lambda_log_group_arn
  jlcrc2_dynamodb_table_arn      = module.dynamodb.jlcrc2_visitor_counter_table_arn
  lambda_function_name           = var.lambda_function_name
  lambda_exec_role_name          = var.lambda_exec_role_name
  lambda_s3_bucket               = var.lambda_s3_bucket_name
  lambda_s3_key                  = var.lambda_s3_key
  dynamodb_table_name            = var.dynamodb_table_name
  dynamodb_table_partition_key   = var.dynamodb_table_partition_key
  dynamodb_table_partition_value = var.dynamodb_table_partition_value
  dynamodb_counter_attribute     = var.dynamodb_table_counter_attribute
}

module "route53" {
  source = "./modules/route53"

  project_name                    = var.project_name
  jlcrc2_domain_name              = var.jlcrc2_domain_name
  jlcrc2_distribution_domain_name = local.jlcrc2_distribution_domain_name
}

module "s3" {
  source = "./modules/s3"

  project_name                 = var.project_name
  account_id                   = local.account_id
  jlcrc2_distribution_id       = module.cloudfront.jlcrc2_distribution_id
  frontend_s3_bucket_name      = var.frontend_s3_bucket_name
  lambda_s3_bucket_name        = var.lambda_s3_bucket_name
  frontend_logs_s3_bucket_name = var.frontend_logs_s3_bucket_name
  terraform_state_bucket_name  = var.terraform_state_bucket_name
  jlcrc2_lambda_exec_role_arn  = local.jlcrc2_lambda_exec_role_arn
}

module "oidc" {
  source = "./modules/oidc"

  github_oidc_backend_deploy_role_name  = var.github_oidc_backend_deploy_role_name
  github_oidc_frontend_deploy_role_name = var.github_oidc_frontend_deploy_role_name
  github_username                       = var.github_username
  github_repo_name                      = var.github_repo_name
  project_name                          = var.project_name
  account_id                            = local.account_id
  frontend_s3_bucket_name               = var.frontend_s3_bucket_name
  frontend_logs_s3_bucket_name          = var.frontend_logs_s3_bucket_name
}