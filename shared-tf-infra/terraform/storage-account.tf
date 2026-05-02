resource "azurerm_storage_account" "this" {
  name                              = lower("${var.businessUnit}${var.applicationId}${var.environmentSingleChar}em28stg1")
  location                          = var.location
  resource_group_name               = data.azurerm_resource_group.this.name
  account_tier                      = var.sa_account_tier
  account_replication_type          = var.sa_account_replication_type
  account_kind                      = var.sa_account_kind
  cross_tenant_replication_enabled  = var.sa_cross_tenant_replication_enabled
  access_tier                       = var.sa_access_tier
  min_tls_version                   = var.sa_min_tls_version
  allow_nested_items_to_be_public   = var.sa_allow_nested_items_to_be_public
  infrastructure_encryption_enabled = var.sa_infrastructure_encryption_enabled
  public_network_access_enabled     = var.sa_public_network_access_enabled

  network_rules {
    default_action = "Deny"
    bypass         = ["AzureServices"]
  }

  tags = local.tags

}

resource "azurerm_private_endpoint" "sablob_pe" {
#  name                = lower(${var.businessUnit})-${var.applicationId}-${var.environmentSingleChar}-em28-sablob-pe
  name =    "${lower(var.businessUnit)}-${var.applicationId}-${var.environmentSingleChar}-em28-sablob-pe"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.this.name
  subnet_id           = data.azurerm_subnet.private_endpoint.id

  private_service_connection {
#    name                           = lower(${var.businessUnit})-${var.applicationId}-${var.environmentSingleChar}-em28-sablob-pe-sc
    name =        "${lower(var.businessUnit)}-${var.applicationId}-${var.environmentSingleChar}-em28-sablob-pe-sc"
    private_connection_resource_id = azurerm_storage_account.this.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }
  ip_configuration {
#    name               = lower(${var.businessUnit})-${var.applicationId}-${var.environmentSingleChar}-em28-sablob-pe-ip
    name =      "${lower(var.businessUnit)}-${var.applicationId}-${var.environmentSingleChar}-em28-sablob-pe-ip"
    private_ip_address = var.sa_blob_private_endpoint_ip
    subresource_name   = "blob"
  }
}