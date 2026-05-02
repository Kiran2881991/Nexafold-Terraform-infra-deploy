data "azurerm_resource_group" "this" {
  name = var.vnet_rg_name
}

data "azurerm_virtual_network" "remote_vnet" {
#  for_each            = var.peered_environments
#  name                = var.peered_environments != "uat" ? "crbatmo-esp-${local.environment_single_char}-em28-vnet" : "crbatmo-esp-${local.environment_single_char}-em28-vnet"
  name                = var.wa_vnet_name
  resource_group_name = var.vnet_rg_name
}

data "azurerm_resource_group" "remote_vnet_rg" {
#  for_each = var.peered_environments
  name     = var.vnet_rg_name
}

data "azurerm_private_endpoint_connection" "kv_pe" {
#  for_each            = var.peered_environments
  name                = "crbatmo-esp-${local.environment_single_char}-em28-kv-pe"
  resource_group_name = var.vnet_rg_name
}

data "azurerm_private_endpoint_connection" "wa_pe_esp" {
#  for_each            = var.peered_environments
  name                = "crbatmo-esp-${local.environment_single_char}-em28-phpapp-pe"
  resource_group_name = var.vnet_rg_name
}

data "azurerm_log_analytics_workspace" "law" {
  name                            = "DefaultWorkspace-Dev-FC"
#  location                        = var.location
#  resource_group_name             = data.azurerm_resource_group.law_rg
  resource_group_name             = var.law_rg_name
}

data "azurerm_key_vault" "this" {
  name                = "crbatmo-esp-d-em28-kv"
  resource_group_name = var.vnet_rg_name
}

data "azurerm_client_config" "current" {}