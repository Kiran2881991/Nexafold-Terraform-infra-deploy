resource "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = data.azurerm_resource_group.this.name
  address_space       = var.vnet_address_space
  dns_servers         = []

  tags = local.tags
}
