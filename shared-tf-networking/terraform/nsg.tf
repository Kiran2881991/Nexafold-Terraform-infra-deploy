# NSG Creation
resource "azurerm_network_security_group" "this" {
  for_each = var.subnets

  name                = join("-", [lower(var.businessUnit), var.applicationId, each.key, var.environmentSingleChar, "nsg"])
  location            = var.location
  resource_group_name = data.azurerm_resource_group.this.name
}

# Create all user defined NSG rules
resource "azurerm_network_security_rule" "this" {
  for_each = local.flattened_rules

  name      = each.value.name
  priority  = each.value.priority
  direction = title(each.value.direction)
  access    = title(each.value.access)
  protocol  = title(each.value.protocol)

  # TODO - Test if each.value.source_port_ranges[0] can be used instead of join
  source_port_range  = length(each.value.source_port_ranges) == 1 ? join("", each.value.source_port_ranges) : null
  source_port_ranges = length(each.value.source_port_ranges) == 1 ? null : each.value.source_port_ranges

  destination_port_range  = length(each.value.destination_port_ranges) == 1 ? join("", each.value.destination_port_ranges) : null
  destination_port_ranges = length(each.value.destination_port_ranges) == 1 ? null : each.value.destination_port_ranges

  source_address_prefix   = length(each.value.source_address_prefixes) == 1 ? join("", each.value.source_address_prefixes) : null
  source_address_prefixes = length(each.value.source_address_prefixes) == 1 ? null : each.value.source_address_prefixes

  destination_address_prefix   = length(each.value.destination_address_prefixes) == 1 ? join("", each.value.destination_address_prefixes) : null
  destination_address_prefixes = length(each.value.destination_address_prefixes) == 1 ? null : each.value.destination_address_prefixes

  network_security_group_name = azurerm_network_security_group.this[each.value.nsg_key].name
  resource_group_name         = data.azurerm_resource_group.this.name
}

# Apply default rules to all NSGs created
resource "azurerm_network_security_rule" "defaults" {
  for_each = { for entry in local.merged_nsg_rules : entry.key => entry.value }

  network_security_group_name = azurerm_network_security_group.this[each.value.nsg_key].name
  resource_group_name         = data.azurerm_resource_group.this.name

  name        = each.value.name
  priority    = each.value.priority
  direction   = title(each.value.direction)
  access      = title(each.value.access)
  protocol    = title(each.value.protocol)
  description = each.value.description

  source_port_range  = length(each.value.source_port_ranges) == 1 ? join("", each.value.source_port_ranges) : null
  source_port_ranges = length(each.value.source_port_ranges) == 1 ? null : each.value.source_port_ranges

  destination_port_range  = length(each.value.destination_port_ranges) == 1 ? join("", each.value.destination_port_ranges) : null
  destination_port_ranges = length(each.value.destination_port_ranges) == 1 ? null : each.value.destination_port_ranges

  source_address_prefix   = length(each.value.source_address_prefixes) == 1 ? join("", each.value.source_address_prefixes) : null
  source_address_prefixes = length(each.value.source_address_prefixes) == 1 ? null : each.value.source_address_prefixes

  destination_address_prefix   = length(each.value.destination_address_prefixes) == 1 ? join("", each.value.destination_address_prefixes) : null
  destination_address_prefixes = length(each.value.destination_address_prefixes) == 1 ? null : each.value.destination_address_prefixes
}