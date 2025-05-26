

resource "aws_apigatewayv2_integration" "lambda_integration" {
    api_id = var.apigw_id
    integration_type = "AWS_PROXY"
    integration_uri = var.lambda_invoke_arn
    integration_method = "POST"
    payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "default_route" {
    api_id = var.apigw_id
    route_key = var.route_key
    target = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}