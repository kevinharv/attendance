/*
    Attendance app Lambda function module.
*/

resource "aws_lambda_function" "function" {
  function_name = "${var.environment}--LAMBDA--Attend--${var.name}"
  description = var.description
  filename = "${path.module}/../../../services/${var.name}/function.zip"
  source_code_hash = filebase64sha256("${path.module}/../../../services/${var.name}/function.zip")

  architectures = [ "arm64" ]
  memory_size = 128
  handler = "app.handler"
  runtime = "python3.12"

  role = var.role_arn
}

/* LAMBDA FUNCTION API GATEWAY ATTACHMENT */

resource "aws_apigatewayv2_integration" "lambda_integration" {
    api_id = var.apigw_id
    integration_type = "AWS_PROXY"
    integration_uri = aws_lambda_function.function.invoke_arn
    integration_method = "POST"
    payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "default_route" {
    api_id = var.apigw_id
    route_key = var.route_key
    target = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
    authorizer_id = var.authorizer_id
    authorization_type = "JWT"
}

/* LAMBDA FUNCTION IAM POLICY */

resource "aws_iam_role_policy_attachment" "lambda_logging_attach" {
  role       = var.role_name
  policy_arn = var.policy_arn
}

resource "aws_lambda_permission" "api_gateway" {
  statement_id = "AllowExecutionFromAPIGateway"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.function.function_name
  principal = "apigateway.amazonaws.com"
  source_arn = "${var.apigw_execution_arn}/*/*"
}