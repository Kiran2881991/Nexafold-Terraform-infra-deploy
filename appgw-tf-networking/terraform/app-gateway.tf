resource "azurerm_application_gateway" "this" {
#  count               = var.deploy_app_gw ? 1 : 0
  name                = "${var.businessUnit}-${var.applicationId}-${local.environment_single_char}-em28-agw01"
  resource_group_name = var.vnet_rg_name
  location            = var.location
  
  #################
  # Static Config #
  #################

  sku {
    name     = var.app_gw_sku_name
    tier     = var.app_gw_sku_tier
    capacity = var.app_gw_sku_capacity
  }

  waf_configuration {
    enabled            = true
    firewall_mode      = "Prevention"
    rule_set_type      = "OWASP"
    rule_set_version   = "3.2"
    request_body_check = true
    dynamic "disabled_rule_group" {
      for_each = var.disabled_rule_groups
      iterator = rulegroup
      content {
        rule_group_name = rulegroup.key
        rules           = rulegroup.value.disabled_rules
      }
    }
  }

  gateway_ip_configuration {
    name      = "${var.businessUnit}-${var.applicationId}-${local.environment_single_char}-em28-agw01-ip"
    subnet_id = azurerm_subnet.this["APPGW"].id
  }

  frontend_ip_configuration {
    name                 = "PublicIP"
    public_ip_address_id = azurerm_public_ip.this.id
  }

  frontend_ip_configuration {
    name                          = "PrivateIP"
    private_ip_address            = var.app_gw_private_ip
    private_ip_address_allocation = "Static"
    subnet_id                     = azurerm_subnet.this["APPGW"].id
  }

  frontend_port {
    name = "HTTPS"
    port = 443
  }

  frontend_port {
    name = "HTTP"
    port = 80
  }
  ssl_policy {
    policy_type = "Predefined"
    policy_name = "AppGwSslPolicy20220101S"
  }

  ##################
  # Dynamic Config #
  ##################
  
  dynamic "ssl_certificate" {
    for_each = var.ssl_certificates
    iterator = cert
    content {
      name                = cert.key
      key_vault_secret_id = cert.value.key_vault_secret_id
    }
  }

# This block has to be used in case you are deploying multiple backend pools
#  dynamic "backend_address_pool" {
#    for_each = var.backend_pools
#    iterator = pool
#    content {
#      name         = pool.key
#      fqdns        = pool.value.backend_pool_fqdns
#      ip_addresses = pool.value.backend_pool_ips
#    }
#  }

# Replaced the above block with this one as only 1 backend pool needs to be added
  backend_address_pool {
    name  = "escapev2-dev"
    fqdns = ["crbatmo-esp-d-em28-phpapp.azurewebsites.net"]
  }

  dynamic "backend_http_settings" {
    for_each = var.app_gw_rules
    iterator = rule
    content {
      name                                = rule.key
      cookie_based_affinity               = rule.value.backend_cookie_based_affinity
      port                                = rule.value.backend_port
      protocol                            = rule.value.backend_protocol
      request_timeout                     = rule.value.backend_request_timeout
      host_name                           = rule.value.backend_hostname
      probe_name                          = "${rule.key}-health-probe"
      pick_host_name_from_backend_address = false
    }
  }

  # # Public Listeners - HTTPS
  dynamic "http_listener" {
    for_each = var.app_gw_rules
    iterator = rule
    content {
      name                           = "${rule.key}-public-https"
      frontend_ip_configuration_name = "PublicIP"
      frontend_port_name             = "HTTPS"
      protocol                       = "Https"
      ssl_certificate_name           = rule.value.ssl_certificate
      host_name                      = rule.value.listener_hostname
    }
  }

  # Public Listeners - HTTP
  dynamic "http_listener" {
    for_each = var.app_gw_rules
    iterator = rule
    content {
      name                           = "${rule.key}-public-http"
      frontend_ip_configuration_name = "PublicIP"
      frontend_port_name             = "HTTP"
      protocol                       = "Http"
      host_name                      = rule.value.listener_hostname
    }
  }

  dynamic "request_routing_rule" {
    for_each = var.app_gw_rules
    iterator = rule
    content {
      name                       = "${rule.key}-public-https"
      http_listener_name         = "${rule.key}-public-https"
      backend_address_pool_name  = rule.value.backend_name
      backend_http_settings_name = rule.key
      priority                   = rule.value.rule_priority
      rule_type                  = rule.value.rule_type
    }
  }

  dynamic "request_routing_rule" {
    for_each = var.app_gw_rules
    iterator = rule
    content {
      name                        = "${rule.key}-public-http-redirect"
      http_listener_name          = "${rule.key}-public-http"
      priority                    = rule.value.redirect_rule_priority
      rule_type                   = "Basic"
      redirect_configuration_name = "${rule.key}-redirect-https"
    }
  }

  dynamic "redirect_configuration" {
    for_each = var.app_gw_rules
    iterator = rule
    content {
      name                 = "${rule.key}-redirect-https"
      target_listener_name = "${rule.key}-public-https"
      redirect_type        = "Permanent"
      include_path         = true
      include_query_string = true
    }
  }

  dynamic "probe" {
    for_each = var.app_gw_rules
    iterator = rule
    content {
      name                                      = "${rule.key}-health-probe"
      protocol                                  = "Https"
      pick_host_name_from_backend_http_settings = false
      host                                      = rule.value.backend_hostname
      interval                                  = rule.value.health_probe_interval
      path                                      = rule.value.health_probe_path
      timeout                                   = rule.value.health_probe_timeout
      unhealthy_threshold                       = rule.value.health_probe_unhealthy_threshold
      port                                      = rule.value.health_probe_port

      match {
        status_code = rule.value.health_probe_status_codes
      }
    }
  }

  identity {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.uai_app_gateway.id
    ]
  }
  depends_on = [
  azurerm_public_ip.this,
  azurerm_subnet.this["APPGW"],
  azurerm_user_assigned_identity.uai_app_gateway,
  azurerm_key_vault_access_policy.app_gateway_kv_access
]

}

resource "azurerm_public_ip" "this" {
  name                = "${var.businessUnit}-${var.applicationId}-${local.environment_single_char}-em28-agw01-pubip01"
  resource_group_name = data.azurerm_resource_group.this.name
  location            = data.azurerm_resource_group.this.location
  allocation_method   = "Static"
  sku                 = "Standard"
}