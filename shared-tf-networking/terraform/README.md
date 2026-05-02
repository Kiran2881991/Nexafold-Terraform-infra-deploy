<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0, < 2.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>4.13.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.13.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_network_security_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_rule.defaults](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_subnet.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_virtual_network.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_businessUnit"></a> [businessUnit](#input\_businessUnit) | Business Unit | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Location where Terraform resources will be deployed | `string` | n/a | yes |
| <a name="input_nsg_rules"></a> [nsg\_rules](#input\_nsg\_rules) | Map of NSG Rules to create, key of object is part of name of resource | <pre>map(list(object({<br>    name                         = string<br>    priority                     = number<br>    direction                    = string<br>    access                       = string<br>    protocol                     = string<br>    source_port_ranges           = list(string)<br>    destination_port_ranges      = list(string)<br>    source_address_prefixes      = list(string)<br>    destination_address_prefixes = list(string)<br>  })))</pre> | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group in which the Networking resources should be deployed into. Used for data lookup. | `string` | n/a | yes |
| <a name="input_sharedAppIds"></a> [sharedAppIds](#input\_sharedAppIds) | List of all Application IDs, 6 digit numbers in a single string, separated with commas. | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Map of Subnets to create, Key of object is part of name of resource, KEY MUST BE ENV-SUFFIX | <pre>map(object({<br>    address_prefixes  = list(string)<br>    service_endpoints = optional(list(string))<br>    delegations = optional(map(object({<br>      name    = string<br>      actions = list(string)<br>    })))<br>  }))</pre> | n/a | yes |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | Name of the VNET in which subnets will be created. Used for data lookup. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->