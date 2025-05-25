/*
    Entrypoint for attendance application infrastructure.
*/

module "lambda_attend" {
  source = "./modules/lambda"
  name   = "attend"
  environment = var.environment
}