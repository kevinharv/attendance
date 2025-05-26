
variable "apigw_id" {
  description = "API Gateway ID"
  type = string
}

variable "route_key" {
  description = "The API Gateway route key for the route. (Ex: GET /user)"
  type = string
}

variable "lambda_invoke_arn" {
  description = "Lambda function invoke ARN."
  type = string
}