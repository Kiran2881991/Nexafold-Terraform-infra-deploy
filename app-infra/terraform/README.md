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
| [azurerm_linux_web_app.wordpress_web_app](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app) | resource |
| [azurerm_mysql_flexible_database.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_database) | resource |
| [azurerm_private_endpoint.wa_pe](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_mysql_flexible_server.common_mfs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/mysql_flexible_server) | data source |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_service_plan.common_asp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/service_plan) | data source |
| [azurerm_subnet.app_service](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_user_assigned_identity.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/user_assigned_identity) | data source |
| [azurerm_virtual_network.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_appId"></a> [appId](#input\_appId) | Application ID, 6 digit number | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment the silos should be deployed into | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Location where Terraform resources will be deployed | `string` | `"francecentral"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group. Used for data lookup. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of Azure Tags which should be assigned to the Azure Resources provisioned by this Terraform stack. | `map(any)` | <pre>{<br>  "terraform": "true"<br>}</pre> | no |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | Name of the VNET in which subnets will be created. Used for data lookup. | `string` | n/a | yes |
| <a name="input_wa_alwayson"></a> [wa\_alwayson](#input\_wa\_alwayson) | App service Always On | `bool` | `true` | no |
| <a name="input_wa_docker_registry_url"></a> [wa\_docker\_registry\_url](#input\_wa\_docker\_registry\_url) | Docker Registry URL | `string` | `"mcr.microsoft.com"` | no |
| <a name="input_wa_private_endpoint_ip"></a> [wa\_private\_endpoint\_ip](#input\_wa\_private\_endpoint\_ip) | Specifies the static IP address within the App Service private endpoint's subnet to be used | `string` | `""` | no |
| <a name="input_wp_admin_admin_user_name"></a> [wp\_admin\_admin\_user\_name](#input\_wp\_admin\_admin\_user\_name) | WP admin user | `string` | n/a | yes |
| <a name="input_wp_admin_email"></a> [wp\_admin\_email](#input\_wp\_admin\_email) | WP admin email | `string` | n/a | yes |
| <a name="input_wp_container_linux_fx_version"></a> [wp\_container\_linux\_fx\_version](#input\_wp\_container\_linux\_fx\_version) | WP Container Image version | `string` | `"appsvc/wordpress-alpine-php"` | no |
| <a name="input_wp_container_start_time_limit"></a> [wp\_container\_start\_time\_limit](#input\_wp\_container\_start\_time\_limit) | WP container start time limit | `string` | `"900"` | no |
| <a name="input_wp_default_site_title"></a> [wp\_default\_site\_title](#input\_wp\_default\_site\_title) | WP Default title | `string` | `"WordPress On Azure App services"` | no |
| <a name="input_wp_locale_code"></a> [wp\_locale\_code](#input\_wp\_locale\_code) | WP Locale Code | `string` | `"en_US"` | no |
| <a name="input_wp_setup_phpadmin"></a> [wp\_setup\_phpadmin](#input\_wp\_setup\_phpadmin) | WP Setup PHP admin for new installs | `string` | `"true"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->