data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

data "azurerm_virtual_network" "this" {
  depends_on = [azurerm_virtual_network.this]  # Ensures VNet is created first
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
}