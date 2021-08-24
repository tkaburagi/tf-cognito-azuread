variable "region" {
    default = "ap-northeast-1"
}

variable "domain_name" {
    default = "acme"
}

variable "cognito_user_pool_name" {
    default = "azureAdConnected"
}

variable "aws_cognito_user_pool_client_name" {
    default = "azureTestApp"
}

variable "azuread_application_name" {
    default = "ad-app"
}

variable "cert_expire_time" {
    default = "2024-01-25T00:00:00Z"
}

variable "tenant_id" {}