<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0, < 2.0.0 |
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | ~>2.1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>4.13.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azapi"></a> [azapi](#provider\_azapi) | 2.1.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.13.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azapi_resource_action.mysql_disable_public_access](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource_action) | resource |
| [azurerm_key_vault.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_mysql_flexible_server.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_server) | resource |
| [azurerm_mysql_flexible_server_active_directory_administrator.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_server_active_directory_administrator) | resource |
| [azurerm_private_endpoint.kv_pe](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.mysql_pe](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.sablob_pe](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_service_plan.app_service_hosting_plan](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan) | resource |
| [azurerm_storage_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_user_assigned_identity.uai_common](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [random_password.database_admin_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_user_assigned_identity.uai_app_gateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/user_assigned_identity) | data source |
| [azurerm_virtual_network.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_appId"></a> [appId](#input\_appId) | Application ID, 6 digit number | `string` | n/a | yes |
| <a name="input_asp_hosting_plan_sku"></a> [asp\_hosting\_plan\_sku](#input\_asp\_hosting\_plan\_sku) | App Service Plan SKU | `string` | `"P1v2"` | no |
| <a name="input_asp_os_type"></a> [asp\_os\_type](#input\_asp\_os\_type) | OS type of the app service plan | `string` | `"Linux"` | no |
| <a name="input_asp_workers"></a> [asp\_workers](#input\_asp\_workers) | App service Workers | `string` | `1` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment the silos should be deployed into | `string` | n/a | yes |
| <a name="input_kv_administrator_objectid"></a> [kv\_administrator\_objectid](#input\_kv\_administrator\_objectid) | ObjectID for administrator to upload certifiate manually. | `string` | `null` | no |
| <a name="input_kv_certificate_permissions"></a> [kv\_certificate\_permissions](#input\_kv\_certificate\_permissions) | List of certificate permissions, must be one or more from the following: Backup, Create, Delete, DeleteIssuers, Get, GetIssuers, Import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers and Update. | `list(any)` | <pre>[<br>  "Create",<br>  "Get",<br>  "List",<br>  "Delete",<br>  "Import",<br>  "Recover"<br>]</pre> | no |
| <a name="input_kv_enabled_for_deployment"></a> [kv\_enabled\_for\_deployment](#input\_kv\_enabled\_for\_deployment) | Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault. | `bool` | `false` | no |
| <a name="input_kv_enabled_for_disk_encrpytion"></a> [kv\_enabled\_for\_disk\_encrpytion](#input\_kv\_enabled\_for\_disk\_encrpytion) | Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys | `bool` | `true` | no |
| <a name="input_kv_key_permissions"></a> [kv\_key\_permissions](#input\_kv\_key\_permissions) | List of key permissions. Possible values are Backup, Create, Decrypt, Delete, Encrypt, Get, Import, List, Purge, Recover, Restore, Sign, UnwrapKey, Update, Verify, WrapKey, Release, Rotate, GetRotationPolicy and SetRotationPolicy | `list(any)` | <pre>[<br>  "Get"<br>]</pre> | no |
| <a name="input_kv_private_endpoint_ip"></a> [kv\_private\_endpoint\_ip](#input\_kv\_private\_endpoint\_ip) | IP Address for the Key Vault Private Endpoint. | `string` | n/a | yes |
| <a name="input_kv_public_network_access_enabled"></a> [kv\_public\_network\_access\_enabled](#input\_kv\_public\_network\_access\_enabled) | Whether public network access is allowed for this Key Vault. Defaults to false. | `bool` | `false` | no |
| <a name="input_kv_purge_protection_enabled"></a> [kv\_purge\_protection\_enabled](#input\_kv\_purge\_protection\_enabled) | Boolean value to determine whether purge protection will be enabled on the key vault | `bool` | `true` | no |
| <a name="input_kv_secret_permissions"></a> [kv\_secret\_permissions](#input\_kv\_secret\_permissions) | List of secret permissions, must be one or more from the following: Backup, Delete, Get, List, Purge, Recover, Restore and Set | `list(any)` | <pre>[<br>  "Get",<br>  "Set",<br>  "List"<br>]</pre> | no |
| <a name="input_kv_sku"></a> [kv\_sku](#input\_kv\_sku) | The Name of the SKU used for this Key Vault. Possible values are standard and premium | `string` | `"standard"` | no |
| <a name="input_kv_soft_delete_retention_days"></a> [kv\_soft\_delete\_retention\_days](#input\_kv\_soft\_delete\_retention\_days) | The number of days that items should be retained for once soft-deleted. This value can be between 7 and 90 days. | `number` | `7` | no |
| <a name="input_kv_storage_permissions"></a> [kv\_storage\_permissions](#input\_kv\_storage\_permissions) | List of storage permissions, must be one or more from the following: Backup, Delete, DeleteSAS, Get, GetSAS, List, ListSAS, Purge, Recover, RegenerateKey, Restore, Set, SetSAS and Update | `list(any)` | <pre>[<br>  "Get"<br>]</pre> | no |
| <a name="input_location"></a> [location](#input\_location) | Location where Terraform resources will be deployed | `string` | `"francecentral"` | no |
| <a name="input_mfs_db_database_backup_retention_days"></a> [mfs\_db\_database\_backup\_retention\_days](#input\_mfs\_db\_database\_backup\_retention\_days) | how long to keep MySQL backup | `string` | `"7"` | no |
| <a name="input_mfs_db_database_georedundant_backup"></a> [mfs\_db\_database\_georedundant\_backup](#input\_mfs\_db\_database\_georedundant\_backup) | Geo-Redundant Backup Enabled | `string` | `"false"` | no |
| <a name="input_mfs_db_database_version"></a> [mfs\_db\_database\_version](#input\_mfs\_db\_database\_version) | SQL DB Version | `string` | `"8.0.21"` | no |
| <a name="input_mfs_db_sql_sku"></a> [mfs\_db\_sql\_sku](#input\_mfs\_db\_sql\_sku) | SQL SKU Size | `string` | `"GP_Standard_D2ds_v4"` | no |
| <a name="input_mfs_db_storage_autogrow"></a> [mfs\_db\_storage\_autogrow](#input\_mfs\_db\_storage\_autogrow) | SQL DB Storage Autogrow | `bool` | `true` | no |
| <a name="input_mfs_db_storage_iops"></a> [mfs\_db\_storage\_iops](#input\_mfs\_db\_storage\_iops) | SQL DB Storage IOPS | `string` | `"700"` | no |
| <a name="input_mfs_db_storage_size_gb"></a> [mfs\_db\_storage\_size\_gb](#input\_mfs\_db\_storage\_size\_gb) | SQL DB Storage Size | `string` | `"128"` | no |
| <a name="input_mfs_private_endpoint_ip"></a> [mfs\_private\_endpoint\_ip](#input\_mfs\_private\_endpoint\_ip) | Specifies the static IP address within the private endpoint subnet to be used for MySQL | `string` | `""` | no |
| <a name="input_mfs_server_username"></a> [mfs\_server\_username](#input\_mfs\_server\_username) | DB Server Username | `string` | `"wpdbadmusr"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group. Used for data lookup. | `string` | n/a | yes |
| <a name="input_sa_access_tier"></a> [sa\_access\_tier](#input\_sa\_access\_tier) | Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool, defaults to Hot | `string` | `"Hot"` | no |
| <a name="input_sa_account_kind"></a> [sa\_account\_kind](#input\_sa\_account\_kind) | Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Defaults to StorageV2 | `string` | `"StorageV2"` | no |
| <a name="input_sa_account_replication_type"></a> [sa\_account\_replication\_type](#input\_sa\_account\_replication\_type) | Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS. Changing this forces a new resource to be created when types LRS, GRS and RAGRS are changed to ZRS, GZRS or RAGZRS and vice versa | `string` | `"GRS"` | no |
| <a name="input_sa_account_tier"></a> [sa\_account\_tier](#input\_sa\_account\_tier) | Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid. Changing this forces a new resource to be created | `string` | `"Standard"` | no |
| <a name="input_sa_allow_nested_items_to_be_public"></a> [sa\_allow\_nested\_items\_to\_be\_public](#input\_sa\_allow\_nested\_items\_to\_be\_public) | Allow or disallow nested items within this Account to opt into being public. Defaults to true | `bool` | `false` | no |
| <a name="input_sa_blob_private_endpoint_ip"></a> [sa\_blob\_private\_endpoint\_ip](#input\_sa\_blob\_private\_endpoint\_ip) | Specifies the static IP address within the Azure Storage Blob private endpoint's subnet to be used | `string` | `""` | no |
| <a name="input_sa_cross_tenant_replication_enabled"></a> [sa\_cross\_tenant\_replication\_enabled](#input\_sa\_cross\_tenant\_replication\_enabled) | Should cross Tenant replication be enabled? Defaults to true | `string` | `false` | no |
| <a name="input_sa_infrastructure_encryption_enabled"></a> [sa\_infrastructure\_encryption\_enabled](#input\_sa\_infrastructure\_encryption\_enabled) | Whether Infrastructure Encryption is enabled.  Defaults to false | `bool` | `true` | no |
| <a name="input_sa_min_tls_version"></a> [sa\_min\_tls\_version](#input\_sa\_min\_tls\_version) | The minimum supported TLS version for the storage account. Possible values are TLS1\_0, TLS1\_1, and TLS1\_2. Defaults to TLS1\_2 for new storage accounts | `string` | `"TLS1_2"` | no |
| <a name="input_sa_public_network_access_enabled"></a> [sa\_public\_network\_access\_enabled](#input\_sa\_public\_network\_access\_enabled) | Whether the public network access is enabled? Defaults to true | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of Azure Tags which should be assigned to the Azure Resources provisioned by this Terraform stack. | `map(any)` | <pre>{<br>  "terraform": "true"<br>}</pre> | no |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | Name of the VNET in which subnets will be created. Used for data lookup. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->