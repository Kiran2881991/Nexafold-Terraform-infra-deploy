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
| [azurerm_application_gateway.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_gateway) | resource |
| [azurerm_log_analytics_workspace.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |
| [azurerm_monitor_diagnostic_setting.appgateway-diagnostics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_network_security_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_rule.defaults](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_private_dns_a_record.kv_dns_a](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.wa_dns_a_ffsa](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.wa_dns_a_hipcover](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_zone.kv_pdns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone.wa_pdns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.kv_pdns_vnet_link](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.wa_pdns_vnet_link](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_public_ip.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_subnet.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_user_assigned_identity.uai_app_gateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azurerm_virtual_network.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_virtual_network_peering.remote](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [azurerm_virtual_network_peering.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [azurerm_private_endpoint_connection.kv_pe](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_endpoint_connection) | data source |
| [azurerm_private_endpoint_connection.wa_pe_ffsa](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_endpoint_connection) | data source |
| [azurerm_private_endpoint_connection.wa_pe_hipcover](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_endpoint_connection) | data source |
| [azurerm_resource_group.remote_vnet_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_virtual_network.remote_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_action_group_name"></a> [action\_group\_name](#input\_action\_group\_name) | The name given to the action group to asign metrics too | `string` | `"CriticalAlertsAction"` | no |
| <a name="input_action_group_short_name"></a> [action\_group\_short\_name](#input\_action\_group\_short\_name) | The short name given to the action group to asign metrics too | `string` | `"p0action"` | no |
| <a name="input_alert_criteria"></a> [alert\_criteria](#input\_alert\_criteria) | The criteria values that activates the alert | <pre>object({<br>    alert_metric_name = string<br>    alert_aggregation = string<br>    alert_operator    = string<br>    alert_threshold   = string<br>  })</pre> | `null` | no |
| <a name="input_appId"></a> [appId](#input\_appId) | Application ID, 6 digit number | `string` | n/a | yes |
| <a name="input_app_gw_diagnostics_enabled"></a> [app\_gw\_diagnostics\_enabled](#input\_app\_gw\_diagnostics\_enabled) | Whether to enable logging and metrics for the Application Gateway to the Log Analytics Workspace | `bool` | `true` | no |
| <a name="input_app_gw_private_ip"></a> [app\_gw\_private\_ip](#input\_app\_gw\_private\_ip) | The Private IP address to associate with the App Gateway. | `string` | n/a | yes |
| <a name="input_app_gw_rules"></a> [app\_gw\_rules](#input\_app\_gw\_rules) | Map of objects to configure a rule, listeners and probes. The key is used to name various resources. | <pre>map(object({<br>    rule_type                        = string<br>    rule_priority                    = number<br>    redirect_rule_priority           = number<br>    listener_hostname                = string<br>    backend_name                     = string<br>    backend_cookie_based_affinity    = optional(string, "Enabled")<br>    backend_port                     = optional(number, 443)<br>    backend_protocol                 = optional(string, "Https")<br>    backend_request_timeout          = optional(number, 30)<br>    backend_hostname                 = optional(string, null)<br>    ssl_certificate                  = optional(string)<br>    health_probe_interval            = optional(number, 30)<br>    health_probe_path                = optional(string, "/")<br>    health_probe_timeout             = optional(number, 30)<br>    health_probe_unhealthy_threshold = optional(number, 3)<br>    health_probe_port                = optional(number, 443)<br>    health_probe_status_codes        = optional(list(number), [200])<br><br>  }))</pre> | `{}` | no |
| <a name="input_app_gw_sku_capacity"></a> [app\_gw\_sku\_capacity](#input\_app\_gw\_sku\_capacity) | (Optional) The Capacity of the SKU to use for this Application Gateway. | `number` | `1` | no |
| <a name="input_app_gw_sku_name"></a> [app\_gw\_sku\_name](#input\_app\_gw\_sku\_name) | The Name of the SKU to use for the Application Gateway. | `string` | `"WAF_v2"` | no |
| <a name="input_app_gw_sku_tier"></a> [app\_gw\_sku\_tier](#input\_app\_gw\_sku\_tier) | The Tier of the SKU to use for the Application Gateway. | `string` | `"WAF_v2"` | no |
| <a name="input_backend_pools"></a> [backend\_pools](#input\_backend\_pools) | Map of objects to configure backend pools. | <pre>map(object({<br>    backend_pool_ips   = optional(list(string), null)<br>    backend_pool_fqdns = optional(list(string), null)<br><br>  }))</pre> | `{}` | no |
| <a name="input_businessUnit"></a> [businessUnit](#input\_businessUnit) | Business Unit | `string` | n/a | yes |
| <a name="input_deploy_app_gw"></a> [deploy\_app\_gw](#input\_deploy\_app\_gw) | Whether to deploy Application Gateway or not.  Should be set to false for initial deployment until a backend and SSL certificate is available. | `bool` | `false` | no |
| <a name="input_disabled_rule_groups"></a> [disabled\_rule\_groups](#input\_disabled\_rule\_groups) | n/a | <pre>map(object({<br>    disabled_rules = list(string)<br>  }))</pre> | `{}` | no |
| <a name="input_email_receiver"></a> [email\_receiver](#input\_email\_receiver) | The details of the intended email reciever. Requries a name and email address. | <pre>object({<br>    name                    = string<br>    email_address           = string<br>    use_common_alert_schema = optional(bool, true)<br>  })</pre> | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment the silos should be deployed into | `string` | n/a | yes |
| <a name="input_law_allow_resource_only_permissions"></a> [law\_allow\_resource\_only\_permissions](#input\_law\_allow\_resource\_only\_permissions) | Specifies if the log Analytics Workspace allow users accessing to data associated with resources they have permission to view, without permission to workspace. Defaults to true | `bool` | `true` | no |
| <a name="input_law_internet_ingestion_enabled"></a> [law\_internet\_ingestion\_enabled](#input\_law\_internet\_ingestion\_enabled) | Should the Log Analytics Workspace support ingestion over the Public Internet? Defaults to true | `bool` | `true` | no |
| <a name="input_law_internet_query_enabled"></a> [law\_internet\_query\_enabled](#input\_law\_internet\_query\_enabled) | Should the Log Analytics Workspace support querying over the Public Internet? Defaults to true | `bool` | `false` | no |
| <a name="input_law_local_authentication_disabled"></a> [law\_local\_authentication\_disabled](#input\_law\_local\_authentication\_disabled) | Specifies if the log Analytics workspace should enforce authentication using Azure AD. Defaults to false | `bool` | `false` | no |
| <a name="input_law_retention_in_days"></a> [law\_retention\_in\_days](#input\_law\_retention\_in\_days) | The workspace data retention in days. Possible values are either 7 (Free Tier only) or range between 30 and 730 | `number` | `30` | no |
| <a name="input_law_sku"></a> [law\_sku](#input\_law\_sku) | Specifies the SKU of the Log Analytics Workspace. Possible values are PerNode, Premium, Standard, Standalone, Unlimited, CapacityReservation, and PerGB2018 (new SKU as of 2018-04-03). Defaults to PerGB2018 | `string` | `"PerGB2018"` | no |
| <a name="input_location"></a> [location](#input\_location) | Location where Terraform resources will be deployed | `string` | n/a | yes |
| <a name="input_nsg_rules"></a> [nsg\_rules](#input\_nsg\_rules) | Map of NSG Rules to create, key of object is part of name of resource | <pre>map(list(object({<br>    name                         = string<br>    priority                     = number<br>    direction                    = string<br>    access                       = string<br>    protocol                     = string<br>    source_port_ranges           = list(string)<br>    destination_port_ranges      = list(string)<br>    source_address_prefixes      = list(string)<br>    destination_address_prefixes = list(string)<br>  })))</pre> | n/a | yes |
| <a name="input_peered_environments"></a> [peered\_environments](#input\_peered\_environments) | Environments to peer to. | `set(string)` | n/a | yes |
| <a name="input_sharedAppIds"></a> [sharedAppIds](#input\_sharedAppIds) | List of all Application IDs, 6 digit numbers in a single string, separated with commas. | `string` | n/a | yes |
| <a name="input_ssl_certificates"></a> [ssl\_certificates](#input\_ssl\_certificates) | Map of objects to configure SSL certificates. | <pre>map(object({<br>    key_vault_secret_id = string<br>    # key_vault_certificate_name      = string<br>    # source_key_vault                = string<br>    # source_key_vault_resource_group = string<br>  }))</pre> | `{}` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Map of Subnets to create, Key of object is part of name of resource, KEY MUST BE ENV-SUFFIX | <pre>map(object({<br>    address_prefixes  = list(string)<br>    service_endpoints = optional(list(string))<br>  }))</pre> | n/a | yes |
| <a name="input_vnet_address_space"></a> [vnet\_address\_space](#input\_vnet\_address\_space) | CIDR range for VNET address space. | `string` | `null` | no |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | Name of the VNET in which subnets will be created. Used for data lookup. | `string` | n/a | yes |
| <a name="input_vnet_rg_name"></a> [vnet\_rg\_name](#input\_vnet\_rg\_name) | Name of the resource group in which the App GW VNET resides. Used for data lookup. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->