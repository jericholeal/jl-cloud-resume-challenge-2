# Locals

data "aws_caller_identity" "current" {}

locals {

  account_id = data.aws_caller_identity.current.account_id

  # ACM
  jlcrc2_cert_id             = module.acm.acm_certificate_id
  jlcrc2_cert_arn            = module.acm.acm_certificate_arn
  jlcrc2_cert_validation_arn = module.acm.acm_certificate_validation_arn

  # Lambda
  jlcrc2_visitor_counter_function_name = module.lambda.jlcrc2_visitor_counter_function_name
  jlcrc2_visitor_counter_function_arn  = module.lambda.jlcrc2_visitor_counter_function_arn
  jlcrc2_visitor_counter_function_id   = module.lambda.jlcrc2_visitor_counter_function_id
  jlcrc2_lambda_exec_role_name         = module.lambda.jlcrc2_lambda_exec_role_name
  jlcrc2_lambda_exec_role_arn          = module.lambda.jlcrc2_lambda_exec_role_arn

  # CloudFront
  jlcrc2_distribution_domain_name = module.cloudfront.jlcrc2_distribution_domain_name
  jlcrc2_distribution_id          = module.cloudfront.jlcrc2_distribution_id
  jlcrc2_oac_id                   = module.cloudfront.jlcrc2_oac_id

  # DynamoDB
  jlcrc2_dynamodb_table_arn = module.dynamodb.jlcrc2_visitor_counter_table_arn
  jlcrc2_dynamodb_table_id  = module.dynamodb.jlcrc2_visitor_counter_table_id

  # S3
  jlcrc2_frontend_bucket_id  = module.s3.jlcrc2_frontend_bucket_id
  jlcrc2_frontend_bucket_arn = module.s3.jlcrc2_frontend_bucket_arn

  # Route53
  jlcrc2_route53_zone_id = module.route53.jlcrc2_route53_zone_id

  # CloudWatch
  lambda_log_group_arn = module.cloudwatch.lambda_log_group_arn
  lambda_log_group_id  = module.cloudwatch.lambda_log_group_id
}

