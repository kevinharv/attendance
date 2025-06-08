

output "cognito_endpoint" {
  value = aws_cognito_user_pool.user_pool.endpoint
}

output "apigw_client_id" {
  value = aws_cognito_user_pool_client.apigw_app.id
}