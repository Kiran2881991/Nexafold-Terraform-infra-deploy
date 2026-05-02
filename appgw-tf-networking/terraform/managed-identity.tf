resource "azurerm_user_assigned_identity" "uai_app_gateway" {
  name                = "${var.businessUnit}-${var.applicationId}-${local.environment_single_char}-em28-agw01-uai"
  resource_group_name = data.azurerm_resource_group.this.name
  location            = data.azurerm_resource_group.this.location
}

resource "azurerm_key_vault_access_policy" "app_gateway_kv_access" {
  key_vault_id = data.azurerm_key_vault.this.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = azurerm_user_assigned_identity.uai_app_gateway.principal_id

  secret_permissions = [
    "Get",
    "List",
  ]
}
