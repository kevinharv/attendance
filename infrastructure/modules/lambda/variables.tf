
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