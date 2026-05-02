data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

data "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
#  address_space       = var.vnet_address_space
#  location            = var.location
}

# Subnet Lookups
data "azurerm_subnet" "app_service" {
  name                 = var.subnet_name
  virtual_network_name = data.azurerm_virtual_network.this.name
  resource_group_name  = var.resource_group_name
}

data "azurerm_service_plan" "common_asp" {
  name                = "${var.businessunit}-${var.applicationId}-${local.environment_single_char}-em28-asp"
#  location            = var.location
  resource_group_name = var.resource_group_name
#  kind                = "Linux"

#  sku {
#    tier = "PremiumV3"
#    size = "P0v3"
#  }
}

data "azurerm_mysql_flexible_server" "common_mfs" {
  name                   = "${var.businessunit}-${var.applicationId}-${local.environment_single_char}-em28-msql"
  resource_group_name    = var.resource_group_name
#  location               = var.location
#  administrator_login    = "dbadmusr"

}

data "azurerm_subnet" "private_endpoint" {
  name                 = var.wa_pe_subnet_name
  virtual_network_name = data.azurerm_virtual_network.this.name
  resource_group_name  = var.resource_group_name
}

data "azurerm_user_assigned_identity" "this" {
  name                = "${var.businessunit}-${var.applicationId}-${local.environment_single_char}-em28-common-uai"
  resource_group_name = var.resource_group_name
}