# API Gateway Module Configuration

# Create REST API for lambda function integration
resource "aws_api_gateway_rest_api" "jlcrc2_api" {
  name        = "jlcrc2_api"
  description = "API gateway for visitor counter Lambda function trigger"
}

# Create resource path
resource "aws_api_gateway_resource" "increment" {
  rest_api_id = aws_api_gateway_rest_api.jlcrc2_api.id
  parent_id   = aws_api_gateway_rest_api.jlcrc2_api.root_resource_id
  path_part   = "increment"
}

# Create GET method on path
resource "aws_api_gateway_method" "increment_get" {
  rest_api_id   = aws_api_gateway_rest_api.jlcrc2_api.id
  resource_id   = aws_api_gateway_resource.increment.id
  http_method   = "GET"
  authorization = "NONE"
}

# Integrate GET method with Lambda function
resource "aws_api_gateway_integration" "increment_get_lambda" {
  rest_api_id             = aws_api_gateway_rest_api.jlcrc2_api.id
  resource_id             = aws_api_gateway_resource.increment.id
  http_method             = aws_api_gateway_method.increment_get.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.aws_region}:lambda:path/2015-03-31/functions/${var.jlcrc2_visitor_counter_function_arn}/invocations"
}

# Create POST method on path
resource "aws_api_gateway_method" "increment_post" {
  rest_api_id   = aws_api_gateway_rest_api.jlcrc2_api.id
  resource_id   = aws_api_gateway_resource.increment.id
  http_method   = "POST"
  authorization = "NONE"
}

# Integrate POST method with Lambda function
resource "aws_api_gateway_integration" "increment_post_lambda" {
  rest_api_id             = aws_api_gateway_rest_api.jlcrc2_api.id
  resource_id             = aws_api_gateway_resource.increment.id
  http_method             = aws_api_gateway_method.increment_post.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.aws_region}:lambda:path/2015-03-31/functions/${var.jlcrc2_visitor_counter_function_arn}/invocations"
}

# Create OPTIONS method for CORS support
resource "aws_api_gateway_method" "increment_options" {
  rest_api_id   = aws_api_gateway_rest_api.jlcrc2_api.id
  resource_id   = aws_api_gateway_resource.increment.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

# Integrate OPTIONS method with Lambda function
resource "aws_api_gateway_integration" "increment_options_lambda" {
  rest_api_id             = aws_api_gateway_rest_api.jlcrc2_api.id
  resource_id             = aws_api_gateway_resource.increment.id
  http_method             = aws_api_gateway_method.increment_options.http_method
  type                    = "MOCK"

  request_templates = {
    "application/json" = jsonencode({
      statusCode = 200
    })
  }

  passthrough_behavior = "WHEN_NO_MATCH"
}

# Create options method response for CORS
resource "aws_api_gateway_method_response" "options_200" {
  rest_api_id = aws_api_gateway_rest_api.jlcrc2_api.id
  resource_id = aws_api_gateway_resource.increment.id
  http_method = "OPTIONS"
  status_code = "200"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Headers" = true
  }
}

# Create options integration response for CORS
resource "aws_api_gateway_integration_response" "options_200" {
  rest_api_id = aws_api_gateway_rest_api.jlcrc2_api.id
  resource_id = aws_api_gateway_resource.increment.id
  http_method = aws_api_gateway_method.increment_options.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
    "method.response.header.Access-Control-Allow-Methods" = "'GET, POST, OPTIONS'"
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
  }

  depends_on = [
    aws_api_gateway_integration.increment_options_lambda,
    aws_api_gateway_method_response.options_200
    ]

}

# Grant permission for API Gateway to invoke Lambda function
resource "aws_lambda_permission" "increment_post_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.jlcrc2_api.execution_arn}/*/POST/increment"
}

resource "aws_lambda_permission" "increment_get_permission" {
  statement_id  = "AllowAPIGatewayInvokeGet"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.jlcrc2_api.execution_arn}/*/GET/increment"
}

# Deploy API (required for API Gateway to be accessible)
resource "aws_api_gateway_deployment" "lambda_function_trigger_deployment" {
  depends_on = [
    aws_api_gateway_integration.increment_post_lambda,
    aws_api_gateway_integration.increment_get_lambda,
    aws_api_gateway_integration.increment_options_lambda,
  ]
  rest_api_id = aws_api_gateway_rest_api.jlcrc2_api.id
  description = "Deployment for visitor counter Lambda function API"
}

resource "aws_api_gateway_stage" "lambda_function_trigger_stage" {
  rest_api_id   = aws_api_gateway_rest_api.jlcrc2_api.id
  deployment_id = aws_api_gateway_deployment.lambda_function_trigger_deployment.id
  stage_name    = "prod"
  description   = "Production stage for visitor counter Lambda function API"
}

