#################################################

resource "azurerm_linux_web_app" "php_web_app" {
  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = "true"
    DATABASE_HOST                       = "${data.azurerm_mysql_flexible_server.common_mfs.name}.mysql.database.azure.com"
    DATABASE_USERNAME                   = data.azurerm_user_assigned_identity.this.name
    DATABASE_NAME                       = "${data.azurerm_mysql_flexible_server.common_mfs.name}-db"
    ENTRA_CLIENT_ID                     = data.azurerm_user_assigned_identity.this.client_id
    ENABLE_MYSQL_MANAGED_IDENTITY       = true
    ADMIN_EMAIL                         = var.php_admin_email
    ADMIN_USER                          = var.php_admin_user_name
    SITE_TITLE                          = var.php_default_site_title
    WEBSITES_CONTAINER_START_TIME_LIMIT = var.php_container_start_time_limit
    LOCALE_CODE                         = var.php_locale_code
    SETUP_PHPMYADMIN                    = var.php_setup_phpadmin
  }
  location                      = var.location
  name                          = "${var.businessunit}-${var.applicationId}-${local.environment_single_char}-em28-phpapp"
  resource_group_name           = data.azurerm_resource_group.this.name
  service_plan_id               = data.azurerm_service_plan.common_asp.id
  virtual_network_subnet_id     = data.azurerm_subnet.app_service.id
  client_affinity_enabled       = false
  https_only                    = true
  public_network_access_enabled = false

  site_config {
    ftps_state             = "Disabled"
    always_on              = var.wa_alwayson
    vnet_route_all_enabled = true
    application_stack {
      docker_registry_url = var.wa_docker_registry_url
      docker_image_name   = var.php_container_linux_fx_version
    }
  }

  identity {
    type = "UserAssigned"
    identity_ids = [
      data.azurerm_user_assigned_identity.this.id
    ]
  }

  tags = var.tags
}

resource "azurerm_private_endpoint" "php_pe" {
  name                = "${var.businessunit}-${var.applicationId}-${local.environment_single_char}-em28-phpapp-pe"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.this.name
  subnet_id           = data.azurerm_subnet.private_endpoint.id

  private_service_connection {
    name                           = "${var.businessunit}-${var.applicationId}-${local.environment_single_char}-em28-phpapp-pe-sc"
    private_connection_resource_id = azurerm_linux_web_app.php_web_app.id
    subresource_names              = ["sites"]
    is_manual_connection           = false
  }

  ip_configuration {
    name               = "${var.businessunit}-${var.applicationId}-${local.environment_single_char}-em28-phpapp-pe-ip"
    private_ip_address = var.wa_private_endpoint_ip
    subresource_name   = "sites"
  }
}