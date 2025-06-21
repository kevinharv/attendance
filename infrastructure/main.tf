/*
    Entrypoint for attendance application infrastructure.
*/

# module "homelab_cognito" {
#   source = "./modules/cognito"
#   name = "Homelab User Pool"
#   hosted_zone_id = var.hosted_zone_id
#   cognito_domain = var.cognito_domain

#   # Pass through to allow non-default AWS provider
#   aws_access_key = var.aws_access_key
#   aws_secret_key = var.aws_secret_key
# }

module "apigw_attend" {
  source              = "./modules/api_gateway"
  hosted_zone_id      = var.hosted_zone_id
  domain_name         = "attend.aws.kevharv.com"
  user_pool_client_id = var.client_id
  cognito_endpoint    = var.cognito_endpoint
}

module "lambda_attend" {
  source              = "./modules/lambda"
  name                = "attend"
  environment         = var.environment
  apigw_execution_arn = module.apigw_attend.execution_arn

  apigw_id = module.apigw_attend.api_id
  route_key = "ANY /{proxy+}"
  authorizer_id = module.apigw_attend.authorizer_id

  role_name = aws_iam_role.lambda_exec.name
  role_arn = aws_iam_role.lambda_exec.arn
  policy_arn = aws_iam_policy.lambda_basic_logging.arn
}

/* LAMBDA FUNCTION IAM SETUP */

resource "aws_iam_role" "lambda_exec" {
  name = "lambda_execution_role"

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

resource "aws_iam_policy" "lambda_basic_logging" {
  name = "lambda_basic_logging_policy"

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
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
}