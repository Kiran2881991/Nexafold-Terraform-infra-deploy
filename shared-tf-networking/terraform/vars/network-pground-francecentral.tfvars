sharedAppIds = "003537, 003635" 

businessUnit = "CRB"
location     = "francecentral"
vnet_name    = "crb-hipc-fra-c-em28-vnet"

resource_group_name = "crb-hipc-fra-c-em28-rgrp"

subnets = {
  APPSERVICE = {
    address_prefixes = ["10.223.240.0/25"]
    delegations = {
      appservice = {
        name    = "Microsoft.Web/serverFarms"
        actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
      }
    }
  }
  DATA = {
    address_prefixes = ["10.223.241.0/25"]
    delegations = {
      mysql = {
        name    = "Microsoft.DBforMySQL/flexibleServers"
        actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
      }
    }
  }
  PRIVATEENDPOINT = {
    address_prefixes = ["10.223.241.128/27"]
  }
}


nsg_rules = {
  APPSERVICE = [
    {
      name                         = "AllowHTTPSInbound"
      priority                     = 110
      direction                    = "Inbound"
      access                       = "Allow"
      protocol                     = "Tcp"
      source_port_ranges           = ["*"]
      destination_port_ranges      = ["443"]
      source_address_prefixes      = ["*"]
      destination_address_prefixes = ["10.223.240.0/25"]
    },
    {
      name                         = "AllowPEOutbound"
      priority                     = 110
      direction                    = "Outbound"
      access                       = "Allow"
      protocol                     = "Tcp"
      source_port_ranges           = ["*"]
      destination_port_ranges      = ["443"]
      source_address_prefixes      = ["10.223.240.0/25"]
      destination_address_prefixes = ["10.223.241.128/27"]
    }
  ]

  DATA = [
    {
      name                         = "AllowAppserviceInbound"
      priority                     = 110
      direction                    = "Inbound"
      access                       = "Allow"
      protocol                     = "Tcp"
      source_port_ranges           = ["*"]
      destination_port_ranges      = ["3306"]
      source_address_prefixes      = ["10.223.240.0/25"]
      destination_address_prefixes = ["10.223.241.128/25"]
    }
  ],
  PRIVATEENDPOINT = [
    {
      name                         = "AllowAppserviceInbound"
      priority                     = 110
      direction                    = "Inbound"
      access                       = "Allow"
      protocol                     = "Tcp"
      source_port_ranges           = ["*"]
      destination_port_ranges      = ["443"]
      source_address_prefixes      = ["10.223.240.0/25"]
      destination_address_prefixes = ["10.223.241.128/27"]
    },
    {
      name                         = "AllowAppgatewayInbound"
      priority                     = 120
      direction                    = "Inbound"
      access                       = "Allow"
      protocol                     = "Tcp"
      source_port_ranges           = ["*"]
      destination_port_ranges      = ["443"]
      source_address_prefixes      = ["172.18.0.0/24"]
      destination_address_prefixes = ["10.223.241.128/27"]
    }
  ]

}