locals {

  tags = {
    "AppID" = var.appId
  }

  default_nsg_rules = [

    # Inbound
    {
      name                         = "AllowRDPinbound"
      priority                     = 100
      direction                    = "inbound"
      access                       = "Allow"
      protocol                     = "tcp"
      source_port_ranges           = ["*"]
      destination_port_ranges      = ["3389"]
      source_address_prefixes      = ["10.0.0.0/8"]
      destination_address_prefixes = ["VirtualNetwork"]
      description                  = "Allows inbound RDP to servers."
    },
    {
      name               = "AllowSCCMPatchingtcpinbound"
      priority           = 200
      direction          = "inbound"
      access             = "Allow"
      protocol           = "tcp"
      source_port_ranges = ["*"]
      destination_port_ranges = [
        "80",
        "443",
        "8530",
        "8531"
      ]
      source_address_prefixes      = ["10.0.0.0/8"]
      destination_address_prefixes = ["VirtualNetwork"]
      description                  = "Allows SCCM servers access for patching and monitoring"
    },
    {
      name                         = "AllowWinRMinbound"
      priority                     = 300
      direction                    = "inbound"
      access                       = "Allow"
      protocol                     = "tcp"
      source_port_ranges           = ["*"]
      destination_port_ranges      = ["5985", "5986"]
      source_address_prefixes      = ["10.0.0.0/8"]
      destination_address_prefixes = ["VirtualNetwork"]
      description                  = "Allows inbound WinRM to servers"
    },
    {
      name                    = "SNOWCetPsDeployinbound"
      priority                = 700
      direction               = "inbound"
      access                  = "allow"
      protocol                = "*"
      source_port_ranges      = ["*"]
      destination_port_ranges = ["3389"]
      source_address_prefixes = [
        "10.207.182.230",
        "10.207.182.229",
        "10.207.182.232",
        "10.207.182.231",
        "10.207.182.234",
        "10.207.182.235"
      ]
      destination_address_prefixes = ["VirtualNetwork"]
      description                  = "Allow ServiceNow MID servers to query resources within the VNET"
    },
    {
      name                         = "AllowLocalTaniumInbound"
      priority                     = 800
      direction                    = "inbound"
      access                       = "allow"
      protocol                     = "tcp"
      source_port_ranges           = ["*"]
      destination_port_ranges      = ["17472"]
      source_address_prefixes      = ["VirtualNetwork"]
      destination_address_prefixes = ["VirtualNetwork"]
      description                  = "Allow ServiceNow MID servers to query resources within the VNET"
    },
    {
      name                         = "AllowICMPInbound"
      priority                     = 4060
      direction                    = "inbound"
      access                       = "Allow"
      protocol                     = "icmp"
      source_port_ranges           = ["*"]
      destination_port_ranges      = ["*"]
      source_address_prefixes      = ["VirtualNetwork"]
      destination_address_prefixes = ["*"]
      description                  = "Default rule to allow icmp traffic inbound."
    },
    {
      name                         = "DenyAllinbound"
      priority                     = 4070
      direction                    = "inbound"
      access                       = "deny"
      protocol                     = "*"
      source_port_ranges           = ["*"]
      destination_port_ranges      = ["*"]
      source_address_prefixes      = ["*"]
      destination_address_prefixes = ["*"]
      description                  = "Default rule to deny traffic."
    },

    # Outbound
    {
      name               = "AllowDomainControllersTcpOutbound"
      priority           = 100
      direction          = "outbound"
      access             = "Allow"
      protocol           = "tcp"
      source_port_ranges = ["*"]
      destination_port_ranges = [
        "53",
        "88",
        "135",
        "139",
        "389",
        "445",
        "464",
        "636",
        "1025",
        "3268-3269",
        "5100-5600",
        "5722",
        "9389",
        "49152-65535"
      ]
      source_address_prefixes      = ["VirtualNetwork"]
      destination_address_prefixes = ["10.0.0.0/8"]
      description                  = "Allows outbound tcp traffic to listed Corporate domain controllers."
    },
    {
      name               = "AllowDomainControllersUdpOutbound"
      priority           = 200
      direction          = "outbound"
      access             = "Allow"
      protocol           = "udp"
      source_port_ranges = ["*"]
      destination_port_ranges = [
        "53",
        "88",
        "123",
        "135",
        "137-139",
        "389",
        "445",
        "464",
        "3268-3269",
        "5722",
        "9389",
        "49152-65535"
      ]
      source_address_prefixes      = ["VirtualNetwork"]
      destination_address_prefixes = ["10.0.0.0/8"]
      description                  = "Allows inbound RDP to servers."
    },
    {
      name                         = "AllowAzureKMSOutbound"
      priority                     = 300
      direction                    = "outbound"
      access                       = "Allow"
      protocol                     = "tcp"
      source_port_ranges           = ["*"]
      destination_port_ranges      = ["1688"]
      source_address_prefixes      = ["VirtualNetwork"]
      destination_address_prefixes = ["20.118.99.224"]
      description                  = "Allows outbound traffic to listed Azure KMS servers."
    },
    {
      name                    = "AllowInternalKMSOutbound"
      priority                = 400
      direction               = "outbound"
      access                  = "Allow"
      protocol                = "tcp"
      source_port_ranges      = ["*"]
      destination_port_ranges = ["1688"]
      source_address_prefixes = ["VirtualNetwork"]
      destination_address_prefixes = [
        "10.206.4.228",
        "10.206.4.105",
        "10.165.14.105"
      ]
      description = "Allows outbound traffic to listed Corporate KMS servers."
    },
    {
      name               = "AllowWeboutbound"
      priority           = 500
      direction          = "outbound"
      access             = "Allow"
      protocol           = "tcp"
      source_port_ranges = ["*"]
      destination_port_ranges = [
        "80",
        "443"
      ]
      source_address_prefixes      = ["VirtualNetwork"]
      destination_address_prefixes = ["Internet"]
      description                  = "Allows outbound traffic on ports 80 and 443."
    },
    {
      name               = "AllowSCCMPatchingTcpOutbound"
      priority           = 600
      direction          = "inbound"
      access             = "Allow"
      protocol           = "tcp"
      source_port_ranges = ["*"]
      destination_port_ranges = [
        "80",
        "135",
        "139",
        "443",
        "445",
        "2701",
        "5723",
        "5724",
        "8530-8531",
        "10123",
        "49152-65535"
      ]
      source_address_prefixes      = ["VirtualNetwork"]
      destination_address_prefixes = ["10.0.0.0/8"]
      description                  = "Allows access to SCCM server for patching"
    },
    # This rule will be implemented following confirmation of the specific destination IPs
    # {
    #   name                         = "TaniumCetPsDeployOutbound"
    #   priority                     = 700
    #   direction                    = "outbound"
    #   access                       = "allow"
    #   protocol                     = "tcp"
    #   source_port_ranges           = ["*"]
    #   destination_port_ranges = [
    #     "22",
    #     "443",
    #     "445",
    #     "17449",
    #     "17472",
    #     "17475",
    #     "17486"
    #   ]
    #   source_address_prefixes      = ["VirtualNetwork"]
    #   destination_address_prefixes = ["<specific destinations>"]
    #   description                  = "Allow ServiceNow MID servers to query resources within the VNET"
    # },
    {
      name                         = "AllowLocalTaniumOutbound"
      priority                     = 800
      direction                    = "outbound"
      access                       = "allow"
      protocol                     = "tcp"
      source_port_ranges           = ["*"]
      destination_port_ranges      = ["17472"]
      source_address_prefixes      = ["VirtualNetwork"]
      destination_address_prefixes = ["VirtualNetwork"]
      description                  = "Allow ServiceNow MID servers to query resources within the VNET"
    },
    {
      name                         = "AllowICMPOutbound"
      priority                     = 4060
      direction                    = "outbound"
      access                       = "Allow"
      protocol                     = "icmp"
      source_port_ranges           = ["*"]
      destination_port_ranges      = ["*"]
      source_address_prefixes      = ["*"]
      destination_address_prefixes = ["*"]
      description                  = "Default rule to allow icmp traffic inbound."
    },
    {
      name                         = "DenyAllOutBound"
      priority                     = 4070
      direction                    = "outbound"
      access                       = "deny"
      protocol                     = "*"
      source_port_ranges           = ["*"]
      destination_port_ranges      = ["*"]
      source_address_prefixes      = ["*"]
      destination_address_prefixes = ["*"]
      description                  = "Default rule to deny traffic."
    }
  ]

  merged_nsg_rules = flatten([
    for subnet_key, subnet in var.subnets : [
      for rule in local.default_nsg_rules : {
        key = "${subnet_key}-${rule.name}"
        value = merge(rule, {
          nsg_key = subnet_key
        })
      }
    ]
  ])
  # We first loop over the var.subnets and get the KEY for each subnet created
  # We then loop each default rule and combine this into an object where every default rule is associated to every KEY from the subnet

  # Example Inputs
  #
  # subnets = {
  #   EXAMPLE-SUBNET = {
  #     address_prefixes = ["10.221.196.96/27"]
  #   }
  # }
  #
  # default_nsg_rules = [
  #   {
  #     name                         = "RULE-1"
  #     priority                     = 4070
  #     direction                    = "inbound"
  #     access                       = "deny"
  #     protocol                     = "tcp"
  #     source_port_ranges           = ["*"]
  #     destination_port_ranges      = ["5"]
  #     source_address_prefixes      = ["*"]
  #     destination_address_prefixes = ["VirtualNetwork"]
  #     description                  = "Default rule to deny traffic."
  #   },
  # ]
  #
  # Example output
  #   merged_nsg_rules = [
  #   {
  #     key      = "EXAMPLE-SUBNET-RULE1"
  #     name     = "rule1"
  #     priority  = 4070
  #     direction = "inbound"
  #     access    = "deny"
  #     protocol  = "tcp"
  #     /* other rule properties */
  #     nsg_key   = "EXAMPLE-SUBNET"
  #   },
  #   // More rules...
  # ]

  flattened_rules_list = [
    # The flattened_rules_list variable is created using a two-level nested for expression to iterate over the map and its contained lists
    # First, iterating over each key-value pair in var.nsg_rules
    # Then creating a new map including `nsg_key` and rules

    for nsg_key, rules in var.nsg_rules : [
      for idx, rule in rules : {
        nsg_key                      = nsg_key
        name                         = rule.name
        priority                     = rule.priority
        direction                    = rule.direction
        access                       = rule.access
        protocol                     = rule.protocol
        source_port_ranges           = rule.source_port_ranges
        destination_port_ranges      = rule.destination_port_ranges
        source_address_prefixes      = rule.source_address_prefixes
        destination_address_prefixes = rule.destination_address_prefixes
        key                          = "${nsg_key}-${idx}" # Unique key for mapping
      }
    ]
  ]
  # Output example

  # flattened_rules_list = [
  # [
  #   {
  #     nsg_key                      = "DEV-APPNAME-APP"
  #     name                         = "Test_NSG_Rule"
  #     priority                     = 101
  #     direction                    = "outbound"
  #     access                       = "allow"
  #     protocol                     = "tcp"
  #     source_port_ranges           = ["1"]
  #     destination_port_ranges      = ["1"]
  #     source_address_prefixes      = ["*"]
  #     destination_address_prefixes = ["1.1.1.1/32"]
  #     key                          = "DEV-APPNAME-APP-0"
  #   },
  #   // More rules for DEV-APPNAME-APP...
  # ],
  # [
  #   {
  #     nsg_key                      = "DEV-APPNAME-DB"
  #     name                         = "secondrule"
  #     priority                     = 100
  #     direction                    = "outbound"
  #     access                       = "allow"
  #     protocol                     = "tcp"
  #     source_port_ranges           = ["1"]
  #     destination_port_ranges      = ["1"]
  #     source_address_prefixes      = ["*"]
  #     destination_address_prefixes = ["2.2.2.2/32"]
  #     key                          = "DEV-APPNAME-DB-0"
  #   }
  #   // More rules for DEV-APPNAME-DB...
  # ]

  flattened_rules = {
    for rule in flatten(local.flattened_rules_list) :
    rule.key => rule
    # We then assign associated key to each item from the flat list resulting in a new object of objects for association.
  }
  # Example output
  #   flattened-rules = {
  #   "DEV-APPNAME-APP-0" = {
  #     nsg_key                      = "DEV-APPNAME-APP"
  #     name                         = "Test_NSG_Rule"
  #     priority                     = 101
  #     direction                    = "outbound"
  #     access                       = "allow"
  #     protocol                     = "tcp"
  #     source_port_ranges           = ["1"]
  #     destination_port_ranges      = ["1"]
  #     source_address_prefixes      = ["*"]
  #     destination_address_prefixes = ["1.1.1.1/32"]
  #     key                          = "DEV-APPNAME-APP-0"
  #   },
  #   "DEV-APPNAME-APP-1" = {
  #     nsg_key                      = "DEV-APPNAME-APP"
  #     name                         = "Test_NSG_Rule2"
  #     priority                     = 102
  #     direction                    = "outbound"
  #     access                       = "allow"
  #     protocol                     = "tcp"
  #     source_port_ranges           = ["2"]
  #     destination_port_ranges      = ["2"]
  #     source_address_prefixes      = ["*"]
  #     destination_address_prefixes = ["2.2.2.2/32"]
  #     key                          = "DEV-APPNAME-APP-1"
  #   },
  #   "DEV-APPNAME-DB-0" = {
  #     nsg_key                      = "DEV-APPNAME-DB"
  #     name                         = "secondrule"
  #     priority                     = 100
  #     direction                    = "outbound"
  #     access                       = "allow"
  #     protocol                     = "tcp"
  #     source_port_ranges           = ["1"]
  #     destination_port_ranges      = ["1"]
  #     source_address_prefixes      = ["*"]
  #     destination_address_prefixes = ["2.2.2.2/32"]
  #     key                          = "DEV-APPNAME-DB-0"
  #   }
  #   // More rules...
  # }
}