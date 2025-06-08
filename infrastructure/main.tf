/*
    Entrypoint for attendance application infrastructure.
*/

variable "cognito_domain" {
  description = "Custom domain for AWS Cognito user pool."
  type        = string
  default     = "auth.aws.kevharv.com"
}

module "lambda_attend" {
  source              = "./modules/lambda"
  name                = "attend"
  environment         = var.environment
  apigw_execution_arn = module.apigw_attend.execution_arn
}

module "apigw_attend" {
  source         = "./modules/api_gateway"
  hosted_zone_id = var.hosted_zone_id
  domain_name    = "attend.aws.kevharv.com"
  user_pool_client_id = aws_cognito_user_pool_client.apigw_app.id
  cognito_endpoint = aws_cognito_user_pool.homelab_user_pool.endpoint
}

/* ========= ROUTE DEFINITIONS ========= */

module "attend_route" {
  source            = "./modules/apigw_lambda_route"
  lambda_invoke_arn = module.lambda_attend.invoke_arn
  apigw_id          = module.apigw_attend.api_id
  route_key         = "ANY /{proxy+}"
}

/* ========= COGNITO CONFIGURATION ========= */

resource "aws_cognito_user_pool" "homelab_user_pool" {
  name = "Homelab User Pool"
}

resource "aws_cognito_user_pool_client" "apigw_app" {
  name         = "API GW Client"
  user_pool_id = aws_cognito_user_pool.homelab_user_pool.id

  allowed_oauth_flows                  = ["code"]
  allowed_oauth_scopes                 = ["openid", "email", "profile"]
  allowed_oauth_flows_user_pool_client = true

  generate_secret              = false
  callback_urls                = ["https://${var.cognito_domain}/callback", "http://localhost:3000/callback"]
  logout_urls                  = ["https://${var.cognito_domain}/logout"]
  supported_identity_providers = ["COGNITO"]
}
