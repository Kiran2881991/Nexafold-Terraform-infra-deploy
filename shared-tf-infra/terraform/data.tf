data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

data "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
}

data "azurerm_subnet" "private_endpoint" {
  name                 = "crbatmo-esp-privateendpoint-d-em28-subn1"
  virtual_network_name = data.azurerm_virtual_network.this.name
  resource_group_name  = data.azurerm_virtual_network.this.resource_group_name
}

#data "azurerm_user_assigned_identity" "uai_app_gateway" {
#  name                = "${lower(var.businessUnit)}-${var.applicationId}-${local.appgw_environment_single_char}-em28-agw01-uai"
#  resource_group_name = "${lower(var.businessUnit)}-${var.applicationId}-${local.appgw_environment_single_char}-em28-rgrp"
#}