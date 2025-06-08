provider "aws" {
  alias  = "use1"
  region = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

/* ========= COGNITO CONFIGURATION ========= */

resource "aws_cognito_user_pool" "user_pool" {
  name = var.name
}

resource "aws_route53_record" "cognito_cf_alias" {
  name    = aws_cognito_user_pool_domain.auth_domain.domain
  type    = "A"
  zone_id = var.hosted_zone_id
  alias {
    evaluate_target_health = false
    name                   = aws_cognito_user_pool_domain.auth_domain.cloudfront_distribution
    zone_id                = aws_cognito_user_pool_domain.auth_domain.cloudfront_distribution_zone_id
  }
}

resource "aws_cognito_user_pool_domain" "auth_domain" {
  domain                = var.cognito_domain
  certificate_arn       = aws_acm_certificate.cognito_cert.arn
  user_pool_id          = aws_cognito_user_pool.user_pool.id
  managed_login_version = 2
}

resource "aws_cognito_user_pool_client" "apigw_app" {
  name         = "API GW Client"
  user_pool_id = aws_cognito_user_pool.user_pool.id

  allowed_oauth_flows                  = ["code"]
  allowed_oauth_scopes                 = ["openid", "email", "profile"]
  allowed_oauth_flows_user_pool_client = true

  generate_secret              = false
  callback_urls                = ["https://${var.cognito_domain}/callback", "http://localhost:3000/callback"]
  logout_urls                  = ["https://${var.cognito_domain}/logout"]
  supported_identity_providers = ["COGNITO"]
}

/* ========= ACM CERT FOR COGNITO ========= */

resource "aws_acm_certificate" "cognito_cert" {
  provider          = aws.use1
  domain_name       = var.cognito_domain
  validation_method = "DNS"
}

resource "aws_route53_record" "cert_validation_dns_record" {
  for_each = {
    for dvo in aws_acm_certificate.cognito_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  zone_id = var.hosted_zone_id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 60
}

# resource "aws_acm_certificate_validation" "cert_validation" {
#   certificate_arn         = aws_acm_certificate.cognito_cert.arn
#   validation_record_fqdns = [for record in aws_route53_record.cert_validation_dns_record : record.fqdn]
# }
