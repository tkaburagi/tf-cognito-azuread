terraform {}

provider "aws" {
  region = var.aws_region
}

provider "azuread" {}