output "cognito-userpool-identifier" {
  value = "urn:amazon:cognito:sp:${aws_cognito_user_pool.pool.id}"
}

output "renspose-url" {
  value = "https://${aws_cognito_user_pool_domain.kabuctl.domain}.auth.${var.region}.amazoncognito.com/saml2/idpresponse"
}
