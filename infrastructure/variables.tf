/*
    Declare all top-level variables required for attendance app.
*/

variable "environment" {
  description = "Deployment Environment Shortname - DEV, QA, PROD"
  type = string
  default = "DEV"
}

variable "aws_region" {
  description = "AWS Region to deploy resources in."
  type        = string
  default     = "us-east-2"
}

variable "aws_access_key" {
  description = "AWS IAM Access Key"
  type = string
}

variable "aws_secret_key" {
  description = "AWS IAM Secret Key"
  type = string
}

variable "hosted_zone_id" {
  description = "Top-level Route53 Hosted Zone ID."
  type = string
}

variable "cognito_domain" {
  description = "Custom domain for AWS Cognito user pool."
  type        = string
  default     = "auth.aws.kevharv.com"
}

variable "client_id" {
  description = "OAuth/OIDC Client ID"
  type = string
}

variable "cognito_endpoint" {
  description = "Cognito endpoint URL. (without https://)"
  type = string
}