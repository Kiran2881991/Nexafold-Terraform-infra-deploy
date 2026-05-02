applicationId = "esp"
appId        = "006525"
environment  = "dev"
businessUnit = "crbatmo"
location     = "francecentral"
vnet_name    = "crbatmo-esp-d-em28-agw-vnet"
subnet_name  = "crbatmo-esp-d-em28-agw-subn1"
vnet_rg_name = "crbatmo-esp-d-em28-rgrp"
wa_vnet_name = "crbatmo-esp-d-em28-vnet"
law_rg_name  = "DefaultResourceGroup-DEV-FC-WEU"

vnet_address_space = "10.4.5.0/24"

#peered_environments = ["dev", "uat"]


subnets = {
  APPGW = {
    address_prefixes = ["10.4.5.0/24"]
  }
}


nsg_rules = {

  APPGW = [
    {
      name                         = "AllowHTTPSInbound"
      priority                     = 110
      direction                    = "Inbound"
      access                       = "Allow"
      protocol                     = "Tcp"
      source_port_ranges           = ["*"]
      destination_port_ranges      = ["443"]
      source_address_prefixes      = ["*"]
      destination_address_prefixes = ["10.4.5.0/24"]
    },
    {
      name                         = "AllowHTTPInbound"
      priority                     = 120
      direction                    = "Inbound"
      access                       = "Allow"
      protocol                     = "Tcp"
      source_port_ranges           = ["*"]
      destination_port_ranges      = ["80"]
      source_address_prefixes      = ["*"]
      destination_address_prefixes = ["10.4.5.0/24"]

    },
    {
      name                         = "AllowGatewayManager"
      priority                     = 130
      direction                    = "Inbound"
      access                       = "Allow"
      protocol                     = "Tcp"
      source_port_ranges           = ["*"]
      destination_port_ranges      = ["65200-65535"]
      source_address_prefixes      = ["GatewayManager"]
      destination_address_prefixes = ["*"]
    },
    {
      name                         = "AllowPEOutbound"
      priority                     = 120
      direction                    = "Outbound"
      access                       = "Allow"
      protocol                     = "Tcp"
      source_port_ranges           = ["*"]
      destination_port_ranges      = ["443"]
      source_address_prefixes      = ["10.4.5.0/24"]
      destination_address_prefixes = ["10.223.244.128/27"]
    }
  ]
}

#########################
###   App Gateway     ###
#########################
deploy_app_gw              = true
app_gw_sku_name            = "WAF_v2"
app_gw_sku_tier            = "WAF_v2"
app_gw_sku_capacity        = "1"
app_gw_private_ip          = "10.4.5.5"
app_gw_diagnostics_enabled = true

app_gw_rules = {
  esp-dev = {
    listener_hostname         = "dev.escape-v2.wtwco.com"
    backend_name              = "escapev2-dev"
    backend_hostname          = "crbatmo-esp-d-em28-phpapp.azurewebsites.net"
    ssl_certificate           = "esp-wildcard-dev"
    rule_type                 = "Basic"
    rule_priority             = 12
    redirect_rule_priority    = 13
    health_probe_status_codes = ["200", "302"]
  }
#  esp-uat = {
#    listener_hostname         = "uat.escape-v2.wtwco.com"
#    backend_name              = "escapev2-uat"
#    backend_hostname          = "crbatmo-esp-u-em28-phpapp.azurewebsites.net"
#    ssl_certificate           = "esp-wildcard-uat"
#    rule_type                 = "Basic"
#    rule_priority             = 16
#    redirect_rule_priority    = 17
#    health_probe_status_codes = ["200", "302"]
#  }
}

backend_pools = {
  esp-dev = {
    backend_pool_fqdns = ["crbatmo-esp-d-em28-phpapp.azurewebsites.net"]
  }
#  esp-uat = {
#    backend_pool_fqdns = ["crbatmo-esp-u-em28-phpapp.azurewebsites.net"]
#  }
}

ssl_certificates = {
  esp-wildcard-dev = {
    key_vault_secret_id = "https://crbatmo-esp-d-em28-kv.vault.azure.net/secrets/hipcover-wild-wtwco-com-12-01-2026" #this is not created yet, need to raise service central request for wildcard certificate for escape v2 application.
  }
#dev secretid suffix - a832c33a60d54624bb3dfd98a69c8d0b  
#  esp-wildcard-uat = {
#    key_vault_secret_id = "https://kv-hipc-u.vault.azure.net/secrets/hipcover-wtwco-com" #this is not created yet, need to raise service central request for wildcard certificate for escape v2 application.
#  }
}

