locals {
  environment_map = {
    dev     = "d"
    uat     = "u"
    prod    = "p"
  }

  # Hipcover      003537

  environment_single_char = local.environment_map[var.environment]
  tags = {
    "AppID"      = var.appId,
 #   "Information" = "Terraform Testing"
  }

  default_nsg_rules = [
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
  #     nsg_key                      = "DEV-BCGER-APP"
  #     name                         = "Test_NSG_Rule"
  #     priority                     = 101
  #     direction                    = "outbound"
  #     access                       = "allow"
  #     protocol                     = "tcp"
  #     source_port_ranges           = ["1"]
  #     destination_port_ranges      = ["1"]
  #     source_address_prefixes      = ["*"]
  #     destination_address_prefixes = ["1.1.1.1/32"]
  #     key                          = "DEV-BCGER-APP-0"
  #   },
  #   // More rules for DEV-BCGER-APP...
  # ],
  # [
  #   {
  #     nsg_key                      = "DEV-BCGER-DB"
  #     name                         = "secondrule"
  #     priority                     = 100
  #     direction                    = "outbound"
  #     access                       = "allow"
  #     protocol                     = "tcp"
  #     source_port_ranges           = ["1"]
  #     destination_port_ranges      = ["1"]
  #     source_address_prefixes      = ["*"]
  #     destination_address_prefixes = ["2.2.2.2/32"]
  #     key                          = "DEV-BCGER-DB-0"
  #   }
  #   // More rules for DEV-BCGER-DB...
  # ]

  flattened_rules = {
    for rule in flatten(local.flattened_rules_list) :
    rule.key => rule
    # We then assign associated key to each item from the flat list resulting in a new object of objects for association.
  }
  # Example output
  #   flattened-rules = {
  #   "DEV-BCGER-APP-0" = {
  #     nsg_key                      = "DEV-BCGER-APP"
  #     name                         = "Test_NSG_Rule"
  #     priority                     = 101
  #     direction                    = "outbound"
  #     access                       = "allow"
  #     protocol                     = "tcp"
  #     source_port_ranges           = ["1"]
  #     destination_port_ranges      = ["1"]
  #     source_address_prefixes      = ["*"]
  #     destination_address_prefixes = ["1.1.1.1/32"]
  #     key                          = "DEV-BCGER-APP-0"
  #   },
  #   "DEV-BCGER-APP-1" = {
  #     nsg_key                      = "DEV-BCGER-APP"
  #     name                         = "Test_NSG_Rule2"
  #     priority                     = 102
  #     direction                    = "outbound"
  #     access                       = "allow"
  #     protocol                     = "tcp"
  #     source_port_ranges           = ["2"]
  #     destination_port_ranges      = ["2"]
  #     source_address_prefixes      = ["*"]
  #     destination_address_prefixes = ["2.2.2.2/32"]
  #     key                          = "DEV-BCGER-APP-1"
  #   },
  #   "DEV-BCGER-DB-0" = {
  #     nsg_key                      = "DEV-BCGER-DB"
  #     name                         = "secondrule"
  #     priority                     = 100
  #     direction                    = "outbound"
  #     access                       = "allow"
  #     protocol                     = "tcp"
  #     source_port_ranges           = ["1"]
  #     destination_port_ranges      = ["1"]
  #     source_address_prefixes      = ["*"]
  #     destination_address_prefixes = ["2.2.2.2/32"]
  #     key                          = "DEV-BCGER-DB-0"
  #   }
  #   // More rules...
  # }
}