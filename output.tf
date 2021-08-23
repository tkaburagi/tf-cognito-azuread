output "cognito-userpool-identifier" {
  value = "urn:amazon:cognito:sp:${aws_cognito_user_pool.pool.id}"
}

output "reply-url" {
  value = "https://${aws_cognito_user_pool_domain.kabuctl.domain}.auth.${var.region}.amazoncognito.com/saml2/idpresponse"
}


output "enterprise-app" {
  value = [
    "Display Name: ${azuread_service_principal.ad-app-principal.display_name}",
    "Application ID: ${azuread_service_principal.ad-app-principal.application_id}",
    "Client ID: ${azuread_service_principal.ad-app-principal.id}",
    "APP Object ID: ${azuread_application.ad-app.object_id}",
    "SP Object ID: ${azuread_service_principal.ad-app-principal.object_id}"
    ]
}