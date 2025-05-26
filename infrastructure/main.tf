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
  hosted_zone_id = var.hosted_zone_id
  domain_name = "attend.aws.kevharv.com"
}

/* ========= ROUTE DEFINITIONS ========= */

module "attend_route" {
  source = "./modules/apigw_lambda_route"
  lambda_invoke_arn = module.lambda_attend.invoke_arn
  apigw_id = module.apigw_attend.api_id
  route_key = "ANY /{proxy+}"
}