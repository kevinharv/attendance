

variable "hosted_zone_id" {
  description = "Hosted Zone ID of the parent Route53 hosted zone."
  type = string
}

variable "domain_name" {
  description = "Domain name (subdomain) for the API Gateway."
  type = string
}

variable "user_pool_client_id" {
  description = "AWS Cognito User Pool Client ID"
  type = string
}

variable "cognito_endpoint" {
  description = "AWS Cognito User Pool Endpoint"
  type = string
}