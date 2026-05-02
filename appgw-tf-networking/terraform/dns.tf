resource "azurerm_private_dns_zone" "kv_pdns_zone" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = var.vnet_rg_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "kv_pdns_vnet_link" {
  name                  = "kv-dnslink"
  resource_group_name   = var.vnet_rg_name
  private_dns_zone_name = azurerm_private_dns_zone.kv_pdns_zone.name
  virtual_network_id    = azurerm_virtual_network.this.id
}

resource "azurerm_private_dns_a_record" "kv_dns_a" {
#  for_each            = var.peered_environments
  name                = "crbatmo-esp-${local.environment_map["dev"]}-em28-kv"
  zone_name           = azurerm_private_dns_zone.kv_pdns_zone.name
  resource_group_name = data.azurerm_resource_group.this.name
  ttl                 = 300
  records             = [data.azurerm_private_endpoint_connection.kv_pe.private_service_connection[0].private_ip_address]
}

resource "azurerm_private_dns_zone" "wa_pdns_zone" {
  name                = "privatelink.azurewebsites.net"
  resource_group_name = data.azurerm_resource_group.this.name
}


resource "azurerm_private_dns_zone_virtual_network_link" "wa_pdns_vnet_link" {
  name                  = "wa-dnslink"
  resource_group_name   = data.azurerm_resource_group.this.name
  private_dns_zone_name = azurerm_private_dns_zone.wa_pdns_zone.name
  virtual_network_id    = azurerm_virtual_network.this.id
}

resource "azurerm_private_dns_a_record" "wa_dns_a_esp" {
#  for_each            = var.peered_environments
  name                = "crbatmo-esp-${local.environment_map["dev"]}-em28-phpapp"
  zone_name           = azurerm_private_dns_zone.wa_pdns_zone.name
  resource_group_name = data.azurerm_resource_group.this.name
  ttl                 = 300
  records             = [data.azurerm_private_endpoint_connection.wa_pe_esp.private_service_connection[0].private_ip_address]
}