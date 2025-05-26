
variable "name" {
  description = "Lambda function name."
  type = string
}

variable "description" {
  description = "Lambda function description."
  type = string
  default = ""
}

variable "environment" {
  description = "Deployment environment shortname."
  type = string
}

variable "apigw_execution_arn" {
  description = "API Gateway Execution ARN"
  type = string
}