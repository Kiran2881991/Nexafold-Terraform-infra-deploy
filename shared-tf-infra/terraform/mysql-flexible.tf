#MySQL Server - Flexible server
resource "azurerm_mysql_flexible_server" "this" {
  name                         = "${lower(var.businessUnit)}-${var.applicationId}-${local.environment_single_char}-em28-msql"
  location                     = var.location
  resource_group_name          = data.azurerm_resource_group.this.name
  sku_name                     = var.mfs_db_sql_sku
  version                      = var.mfs_db_database_version
  backup_retention_days        = var.mfs_db_database_backup_retention_days
  geo_redundant_backup_enabled = var.mfs_db_database_georedundant_backup
  administrator_login          = var.mfs_server_username
  administrator_password       = random_password.database_admin_password.result
  tags                         = var.tags

  storage {
    size_gb           = var.mfs_db_storage_size_gb
    iops              = var.mfs_db_storage_iops
    auto_grow_enabled = var.mfs_db_storage_autogrow
  }
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.uai_common.id]
  }
}

resource "azurerm_mysql_flexible_server_active_directory_administrator" "this" {
  server_id   = azurerm_mysql_flexible_server.this.id
  identity_id = azurerm_user_assigned_identity.uai_common.id
  login       = azurerm_user_assigned_identity.uai_common.name
  object_id   = azurerm_user_assigned_identity.uai_common.client_id
  tenant_id   = data.azurerm_client_config.current.tenant_id
}

resource "azurerm_private_endpoint" "mysql_pe" {
  name                = "${lower(var.businessUnit)}-${var.applicationId}-${local.environment_single_char}-em28-msql-pe"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.this.name
  subnet_id           = data.azurerm_subnet.private_endpoint.id

  private_service_connection {
    name                           = "${lower(var.businessUnit)}-${var.applicationId}-${local.environment_single_char}-em28-msql-pe-sc"
    private_connection_resource_id = azurerm_mysql_flexible_server.this.id
    subresource_names              = ["mysqlServer"]
    is_manual_connection           = false
  }
  ip_configuration {
    name               = "${lower(var.businessUnit)}-${var.applicationId}-${local.environment_single_char}-em28-msql-pe-ip"
    private_ip_address = var.mfs_private_endpoint_ip
    subresource_name   = "mysqlServer"
  }
}

resource "azapi_resource_action" "mysql_disable_public_access" {
#  depends_on = [azurerm_mysql_flexible_server.this]
  type        = "Microsoft.DBforMySQL/flexibleServers@2024-10-01-preview"
  resource_id = azurerm_mysql_flexible_server.this.id
  method      = "PATCH"

  body = {
    properties = {
      network = {
        publicNetworkAccess = "Disabled"
      }
    }
  }

  depends_on = [
    azurerm_private_endpoint.mysql_pe,
    azurerm_mysql_flexible_server.this,
    azurerm_mysql_flexible_server_active_directory_administrator.this
  ]
}

resource "random_password" "database_admin_password" {
  length      = 12
  special     = true
  min_special = 1
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
}