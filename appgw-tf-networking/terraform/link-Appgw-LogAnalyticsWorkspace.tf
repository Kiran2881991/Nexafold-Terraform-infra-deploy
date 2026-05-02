#resource "azurerm_log_analytics_workspace" "this" {
#  name                            = "DefaultWorkspace-Dev-FC"
#  location                        = var.location
#  resource_group_name             = data.azurerm_resource_group.law_rg
#  resource_group_name             = var.law_rg_name
#  sku                             = var.law_sku
#  retention_in_days               = var.law_retention_in_days
#  allow_resource_only_permissions = var.law_allow_resource_only_permissions
#  local_authentication_disabled   = var.law_local_authentication_disabled
#  internet_ingestion_enabled      = var.law_internet_ingestion_enabled
#  internet_query_enabled          = var.law_internet_query_enabled
#}

resource "azurerm_monitor_diagnostic_setting" "appgateway-diagnostics" {
#  count                      = var.app_gw_diagnostics_enabled && var.deploy_app_gw ? 1 : 0
  name                       = "esp-appgateway-diagnostics"
  target_resource_id         = azurerm_application_gateway.this.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.law.id
  enabled_log {
    category = "ApplicationGatewayAccessLog"
  }

  enabled_log {
    category = "ApplicationGatewayPerformanceLog"
  }

  enabled_log {
    category = "ApplicationGatewayFirewallLog"
  }

  metric {
    category = "AllMetrics"
  }
}