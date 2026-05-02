terraform {
  required_version = ">= 1.12.0, < 2.0.0"
  required_providers {

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.13.0"
    }
  }
}

terraform {
  backend "azurerm" {}
}

provider "azurerm" {
  features {
  }
}