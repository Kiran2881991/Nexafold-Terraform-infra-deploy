# Subnet Creation
resource "azurerm_subnet" "this" {
  for_each = var.subnets

  name             = join("-", [lower(var.businessUnit), var.applicationId, each.key, var.environmentSingleChar, "em28", "subn1"])
  address_prefixes = each.value.address_prefixes

  resource_group_name  = data.azurerm_resource_group.this.name
  virtual_network_name = data.azurerm_virtual_network.this.name

  service_endpoints = each.value.service_endpoints

  dynamic "delegation" {
    for_each = each.value.delegations != null ? each.value.delegations : {}
    content {
      name = delegation.value.name
      service_delegation {
        name    = delegation.value.name
        actions = delegation.value.actions
      }
    }
  }
}

# Associate NSG to Subnet
resource "azurerm_subnet_network_security_group_association" "this" {
  for_each = var.subnets

  subnet_id                 = azurerm_subnet.this[each.key].id
  network_security_group_id = azurerm_network_security_group.this[each.key].id
}

