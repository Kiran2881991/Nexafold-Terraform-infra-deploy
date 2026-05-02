appId       = "006525"
applicationId = "esp"
environmentSingleChar = "u"
businessUnit = "CRBATMO"
location     = "francecentral"
vnet_name    = "crbatmo-esp-u-em28-vnet"
vnet_address_space = ["10.223.244.0/24"]
resource_group_name = "crbatmo-esp-u-em28-rgrp"
subnets = {
  appservice = {
    address_prefixes = ["10.80.4.128/26"]
#    address_prefixes = ["10.223.244.0/26"]
    delegations = {
      appservice = {
        name    = "Microsoft.Web/serverFarms"
        actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
      }
    }
  }
  data = {
    address_prefixes = ["10.80.4.64/26"]
#    address_prefixes = ["10.223.244.64/26"]
    delegations = {
      mysql = {
        name    = "Microsoft.DBforMySQL/flexibleServers"
        actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
      }
    }
  }
  privateendpoint = {
    address_prefixes = ["10.80.4.0/27"]
#    address_prefixes = ["10.223.244.128/27"]
  }
}

nsg_rules = {
  appservice = [
    {
      name                         = "AllowHTTPSInbound"
      priority                     = 110
      direction                    = "Inbound"
      access                       = "Allow"
      protocol                     = "Tcp"
      source_port_ranges           = ["*"]
      destination_port_ranges      = ["443"]
      source_address_prefixes      = ["*"]
      destination_address_prefixes = ["10.80.4.128/26"]
    },
    {
      name                         = "AllowPEOutbound"
      priority                     = 110
      direction                    = "Outbound"
      access                       = "Allow"
      protocol                     = "Tcp"
      source_port_ranges           = ["*"]
      destination_port_ranges      = ["443", "3306"]
      source_address_prefixes      = ["10.80.4.128/26"]
      destination_address_prefixes = ["10.80.4.0/27"]
    }
  ]
  data = [
    {
      name                         = "AllowAppserviceInbound"
      priority                     = 110
      direction                    = "Inbound"
      access                       = "Allow"
      protocol                     = "Tcp"
      source_port_ranges           = ["*"]
      destination_port_ranges      = ["3306"]
      source_address_prefixes      = ["10.80.4.128/26"]
      destination_address_prefixes = ["10.80.4.0/27"]
    }
  ],
  privateendpoint = [
    {
      name                         = "AllowWTWInbound"
      priority                     = 105
      direction                    = "Inbound"
      access                       = "Allow"
      protocol                     = "Tcp"
      source_port_ranges           = ["*"]
      destination_port_ranges      = ["443"]
      source_address_prefixes      = ["10.0.0.0/8"]
      destination_address_prefixes = ["10.80.4.0/27"]
    },
    {
      name                         = "AllowAppserviceInbound"
      priority                     = 110
      direction                    = "Inbound"
      access                       = "Allow"
      protocol                     = "Tcp"
      source_port_ranges           = ["*"]
      destination_port_ranges      = ["443", "3306"]
      source_address_prefixes      = ["10.80.4.128/26"]
      destination_address_prefixes = ["10.80.4.0/27"]
    },
    {
      name                         = "AllowAppgatewayInbound"
      priority                     = 120
      direction                    = "Inbound"
      access                       = "Allow"
      protocol                     = "Tcp"
      source_port_ranges           = ["*"]
      destination_port_ranges      = ["443"]
      source_address_prefixes      = ["10.4.5.0/24"]
      destination_address_prefixes = ["10.80.4.0/27"]
    }
  ]
}
