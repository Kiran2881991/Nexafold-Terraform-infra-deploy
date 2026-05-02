terraform {
  required_version = ">= 1.11.0, < 2.0.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.13.0"
    }

    azapi = {
      source  = "azure/azapi"
      version = "~>2.1.0"
    }
  }
}

terraform {
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

provider "azapi" {
}