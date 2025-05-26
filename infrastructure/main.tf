/*
    Entrypoint for attendance application infrastructure.
*/

module "lambda_attend" {
  source = "./modules/lambda"
  name   = "attend"
  environment = var.environment
  apigw_execution_arn = module.apigw_attend.execution_arn
}

module "apigw_attend" {
  source = "./modules/api_gateway"
  lambda_invoke_arn = module.lambda_attend.invoke_arn
}