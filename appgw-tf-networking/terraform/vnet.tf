resource "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = data.azurerm_resource_group.this.name
  address_space       = [var.vnet_address_space]
  dns_servers         = []

  tags = local.tags
}

resource "azurerm_virtual_network_peering" "this" {
#  for_each                     = var.peered_environments
  name                         = "crbatmo-esp-${local.environment_single_char}-appgw-wa-peering"
  virtual_network_name         = azurerm_virtual_network.this.name
  resource_group_name          = data.azurerm_resource_group.this.name
  remote_virtual_network_id    = data.azurerm_virtual_network.remote_vnet.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = false
  allow_gateway_transit        = false
}

resource "azurerm_virtual_network_peering" "remote" {
#  for_each                     = var.peered_environments
  name                         = "crbatmo-esp-${local.environment_single_char}-wa-appgw-peering"
  virtual_network_name         = data.azurerm_virtual_network.remote_vnet.name
  resource_group_name          = data.azurerm_resource_group.remote_vnet_rg.name
  remote_virtual_network_id    = azurerm_virtual_network.this.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = false
  allow_gateway_transit        = false
}