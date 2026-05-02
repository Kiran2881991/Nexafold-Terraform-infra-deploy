sharedAppIds = "003537, 003635"

appId        = "hipc"
environment  = "prod"
businessUnit = "crb"
location     = "francecentral"
vnet_name    = "crb-hipc-fra-p-em28-appg-vnet"
vnet_rg_name = "crb-hipc-fra-p-em28-rgrp"

vnet_address_space = "172.18.0.0/23"

peered_environments = ["prod"]


subnets = {
  APPGW = {
    address_prefixes = ["172.18.0.0/24"]
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
      destination_address_prefixes = ["172.18.0.0/24"]
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
      destination_address_prefixes = ["172.18.0.0/24"]

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
      source_address_prefixes      = ["172.18.0.0/24"]
      destination_address_prefixes = ["10.223.215.128/27"]
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
app_gw_private_ip          = "172.18.0.5"
app_gw_diagnostics_enabled = true

app_gw_rules = {
  hipcover-prod = {
    listener_hostname         = "hipcover.wtwco.com"
    backend_name              = "hipcover-prod"
    backend_hostname          = "wa-003537-p.azurewebsites.net"
    ssl_certificate           = "hipcover-wildcard-prod"
    rule_type                 = "Basic"
    rule_priority             = 12
    redirect_rule_priority    = 13
    health_probe_status_codes = ["200", "302"]
  }
  ffsa-dev = {
    listener_hostname         = "ffsa.wtwco.com"
    backend_name              = "ffsa-prod"
    backend_hostname          = "wa-003635-p.azurewebsites.net"
    ssl_certificate           = "ffsa-wildcard-prod"
    rule_type                 = "Basic"
    rule_priority             = 14
    redirect_rule_priority    = 15
    health_probe_status_codes = ["200", "302"]
  }
}

backend_pools = {
  hipcover-prod = {
    backend_pool_fqdns = ["wa-003537-p.azurewebsites.net"]
  }
  ffsa-prod = {
    backend_pool_fqdns = ["wa-003635-p.azurewebsites.net"]
  }
}

ssl_certificates = {
  hipcover-wildcard-prod = {
    key_vault_secret_id = "https://kv-hipc-p.vault.azure.net/secrets/hipcover-wtwco-com"
  }
  ffsa-wildcard-prod = {
    key_vault_secret_id = "https://kv-hipc-p.vault.azure.net/secrets/ffsa-wtwco-com"
  }
}

