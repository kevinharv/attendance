

variable "name" {
  description = "Name of the Cognito User Pool."
  type = string
}

variable "hosted_zone_id" {
  description = "AWS Route53 Hosted Zone ID for Cognito DNS entries."
  type = string
}

variable "cognito_domain" {
  description = "Cognito custom domain FQDN."
  type = string
}

variable "aws_access_key" {}
variable "aws_secret_key" {}