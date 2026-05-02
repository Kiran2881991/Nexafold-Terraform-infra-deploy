resource "azurerm_key_vault" "this" {
  name                          = "${lower(var.businessUnit)}-${var.applicationId}-${var.environmentSingleChar}-em28-kv"
  location                      = var.location
  resource_group_name           = data.azurerm_resource_group.this.name
  enabled_for_disk_encryption   = var.kv_enabled_for_disk_encrpytion
  tenant_id                     = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days    = var.kv_soft_delete_retention_days
  purge_protection_enabled      = var.kv_purge_protection_enabled
  enabled_for_deployment        = var.kv_enabled_for_deployment
  public_network_access_enabled = var.kv_public_network_access_enabled
  sku_name                      = var.kv_sku

  # Access Policy to allow Pipeline Principal to manage Key Vault objects
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions         = var.kv_key_permissions
    secret_permissions      = var.kv_secret_permissions
    storage_permissions     = var.kv_storage_permissions
    certificate_permissions = var.kv_certificate_permissions
  }

  # # Access Policy to allow App Service to retrieve secrets
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = azurerm_user_assigned_identity.uai_common.principal_id

    key_permissions     = []
    secret_permissions  = ["Get"]
    storage_permissions = []
  }

  # Access Policy to allow App Gateway to retrieve secrets
#  access_policy {
#    tenant_id = data.azurerm_client_config.current.tenant_id
##    object_id = data.azurerm_user_assigned_identity.uai_app_gateway.principal_id
#    object_id = azurerm_user_assigned_identity.uai_app_gateway.principal_id

#    key_permissions     = []
#    secret_permissions  = ["Get"]
#    storage_permissions = []
#  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = var.kv_administrator_objectid

    key_permissions         = var.kv_key_permissions
    secret_permissions      = var.kv_secret_permissions
    storage_permissions     = var.kv_storage_permissions
    certificate_permissions = var.kv_certificate_permissions
  }

  network_acls {
    bypass         = "AzureServices"
    default_action = var.kv_public_network_access_enabled ? "Allow" : "Deny"
  }

  tags = var.kv_public_network_access_enabled ? merge(local.tags, { kvexclude = "UC1" }) : local.tags
}

resource "azurerm_private_endpoint" "kv_pe" {
  count               = var.kv_public_network_access_enabled ? 0 : 1
  name                = "${azurerm_key_vault.this.name}-pe"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.this.name
  subnet_id           = data.azurerm_subnet.private_endpoint.id

  private_service_connection {
    name                           = "${lower(var.businessUnit)}-${var.applicationId}-${local.environment_single_char}-em28-kv-sc"
    private_connection_resource_id = azurerm_key_vault.this.id
    subresource_names              = ["vault"]
    is_manual_connection           = false
  }

  ip_configuration {
    name               = "${lower(var.businessUnit)}-${var.applicationId}-${local.environment_single_char}-em28-kv-ip"
    private_ip_address = var.kv_private_endpoint_ip
    subresource_name   = "vault"
    member_name        = "default"
  }

}