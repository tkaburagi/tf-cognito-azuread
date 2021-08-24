terraform {}

provider "aws" {
  region = var.region
}

provider "azuread" {}