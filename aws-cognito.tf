resource "aws_cognito_user_pool" "pool" {
  name                     = var.cognito_user_pool_name
  auto_verified_attributes = ["email"]
}

resource "aws_cognito_user_pool_domain" "kabuctl" {
  domain       = var.domain
  user_pool_id = aws_cognito_user_pool.pool.id
}

resource "aws_cognito_user_pool_client" "client" {
  name = var.cognito_user_pool_client_name

  user_pool_id         = aws_cognito_user_pool.pool.id
  callback_urls        = var.cognito_callbackurls
  allowed_oauth_scopes = ["email", "openid", "aws.cognito.signin.user.admin"]
  allowed_oauth_flows  = ["code", "implicit"]
}

resource "aws_cognito_identity_provider" "id-provider" {
  //ref: https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_CreateIdentityProvider.html#CognitoUserPools-CreateIdentityProvider-request-AttributeMapping
  provider_details = {
    MetadataFile = file("federationmedata.xml")
  }
  //ref: https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_CreateIdentityProvider.html#CognitoUserPools-CreateIdentityProvider-request-AttributeMapping
  attribute_mapping = {
    "email" = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress"
  }
  provider_name = "azread"
  //ref: https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_CreateIdentityProvider.html#CognitoUserPools-CreateIdentityProvider-request-ProviderType
  provider_type = "SAML"
  user_pool_id  = aws_cognito_user_pool.pool.id

  depends_on = [
    azuread_application.ad-app,
    azuread_service_principal.ad-app-principal
  ]
}