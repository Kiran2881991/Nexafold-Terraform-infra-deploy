#App Service Plan
resource "azurerm_service_plan" "app_service_hosting_plan" {
  location            = var.location
  name                = "${lower(var.businessUnit)}-${var.applicationId}-${local.environment_single_char}-em28-asp"
  os_type             = var.asp_os_type
  resource_group_name = data.azurerm_resource_group.this.name
  sku_name            = var.asp_hosting_plan_sku
  worker_count        = var.asp_workers
  depends_on = [
    azurerm_mysql_flexible_server.this
  ]
}

# resource "azurerm_private_endpoint" "wa_pe" {
#   name                = "pe-wa-${var.appId}-${local.environment_single_char}"
#   location            = var.location
#   resource_group_name = data.azurerm_resource_group.this.name
#   subnet_id           = data.azurerm_subnet.private_endpoint.id

#   private_service_connection {
#     name                           = "sc-${var.appId}-${local.environment_single_char}"
#     private_connection_resource_id = azurerm_linux_web_app.wordpress_web_app.id
#     subresource_names              = ["sites"]
#     is_manual_connection           = false
#   }
#   ip_configuration {
#     name               = "pe-${var.appId}-${local.environment_single_char}-ip"
#     private_ip_address = var.wa_private_endpoint_ip
#     subresource_name   = "sites"
#   }
# }

# resource "azurerm_private_dns_a_record" "wa_dns_a" {
#   name                = azurerm_linux_web_app.wordpress_web_app.name
#   zone_name           = data.azurerm_private_dns_zone.wa_private_dns_zone.name
#   resource_group_name = data.azurerm_resource_group.this.name
#   ttl                 = 300
#   records             = [azurerm_private_endpoint.wa_pe.ip_configuration[0].private_ip_address]
# }