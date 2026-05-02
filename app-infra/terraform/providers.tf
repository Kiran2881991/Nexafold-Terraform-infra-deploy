terraform {
  required_version = ">= 1.11.0, < 2.0.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.13.0"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  tenant_id = "76e3921f-489b-4b7e-9547-9ea297add9b5"

  # Correctly define the features block
  features {}
}