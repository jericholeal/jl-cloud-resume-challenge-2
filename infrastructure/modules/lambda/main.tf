# Lambda Module Configuration

# IAM Role for Lambda execution
resource "aws_iam_role" "jlcrc2_lambda_exec" {
  name = var.lambda_exec_role_name

  # AWS assume policy
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

# IAM Policy for Lambda execution role
resource "aws_iam_role_policy" "jlcrc2_lambda_policy" {
  name = var.lambda_exec_policy_name
  role = aws_iam_role.jlcrc2_lambda_exec.id

  # Policy for Lambda execution role
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "${var.lambda_execution_logs_arn}"
      },
      {
        Effect = "Allow",
        Action = [
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:UpdateItem"
        ],
        Resource = "${var.jlcrc2_dynamodb_table_arn}"
      }
    ]
  })
}

# Lambda function resource
resource "aws_lambda_function" "jlcrc2_visitor_counter_function" {
  function_name = var.lambda_function_name
  s3_bucket     = var.lambda_s3_bucket
  s3_key        = var.lambda_s3_key
  handler       = "${var.lambda_function_name}.lambda_handler"
  runtime       = "python3.9"
  role          = aws_iam_role.jlcrc2_lambda_exec.arn

  environment {
    variables = {
      TABLE_NAME        = var.dynamodb_table_name
      PARTITION_KEY     = var.dynamodb_table_partition_key
      PARTITION_VALUE   = var.dynamodb_table_partition_value
      COUNTER_ATTRIBUTE = var.dynamodb_counter_attribute
    }
  }

  tags = {
    Project = var.project_name
  }
}
