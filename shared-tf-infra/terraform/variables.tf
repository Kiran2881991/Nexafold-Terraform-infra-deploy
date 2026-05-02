variable "appId" {
  type        = string
  description = "Application ID, 6 digit number"
}

variable "applicationId" {
  type    = string
  description = "shortform of the application escapeV2"
}

variable "environment" {
  type        = string
  description = "The environment the silos should be deployed into"
}

variable "environmentSingleChar" {
  type    = string
  description = "This is the environment short code i.e d"
}

variable "businessUnit" {
  type    = string
  description = "This is the project short code i.e CRBATMO"
}

variable "location" {
  type        = string
  description = " Location where Terraform resources will be deployed"
  default     = "francecentral"
}

variable "tags" {
  type = map(any)

  description = <<DESC
    A mapping of Azure Tags which should be assigned to the Azure Resources provisioned by this Terraform stack.
  DESC

  default = {
    terraform = "true"
  }
}

variable "vnet_name" {
  type        = string
  description = "Name of the VNET in which subnets will be created. Used for data lookup."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group. Used for data lookup."
}

#######################
### Storage Account ###
#######################

variable "sa_account_tier" {
  type        = string
  default     = "Standard"
  description = "Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid. Changing this forces a new resource to be created"
}

variable "sa_account_replication_type" {
  type        = string
  default     = "GRS"
  description = "Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS. Changing this forces a new resource to be created when types LRS, GRS and RAGRS are changed to ZRS, GZRS or RAGZRS and vice versa"
}

variable "sa_account_kind" {
  type        = string
  default     = "StorageV2"
  description = "Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Defaults to StorageV2"
}

variable "sa_cross_tenant_replication_enabled" {
  type        = string
  default     = false
  description = "Should cross Tenant replication be enabled? Defaults to true"
}

variable "sa_access_tier" {
  type        = string
  default     = "Hot"
  description = "Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool, defaults to Hot"
}

variable "sa_min_tls_version" {
  type        = string
  default     = "TLS1_2"
  description = "The minimum supported TLS version for the storage account. Possible values are TLS1_0, TLS1_1, and TLS1_2. Defaults to TLS1_2 for new storage accounts"
}

variable "sa_allow_nested_items_to_be_public" {
  type        = bool
  default     = false
  description = "Allow or disallow nested items within this Account to opt into being public. Defaults to true"
}

variable "sa_infrastructure_encryption_enabled" {
  type        = bool
  default     = true
  description = "Whether Infrastructure Encryption is enabled.  Defaults to false"
}

variable "sa_public_network_access_enabled" {
  type        = bool
  default     = false
  description = "Whether the public network access is enabled? Defaults to true"
}

variable "sa_blob_private_endpoint_ip" {
  type        = string
  default     = ""
  description = "Specifies the static IP address within the Azure Storage Blob private endpoint's subnet to be used"
}

######################
### Key Vault Vars ###
######################

variable "kv_enabled_for_disk_encrpytion" {
  type        = bool
  default     = true
  description = "Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys"
}

variable "kv_soft_delete_retention_days" {
  type        = number
  default     = 7
  description = "The number of days that items should be retained for once soft-deleted. This value can be between 7 and 90 days."
}

variable "kv_purge_protection_enabled" {
  type        = bool
  default     = true
  description = "Boolean value to determine whether purge protection will be enabled on the key vault"
}

variable "kv_sku" {
  type        = string
  default     = "standard"
  description = "The Name of the SKU used for this Key Vault. Possible values are standard and premium"
}

variable "kv_key_permissions" {
  type        = list(any)
  default     = ["Get"]
  description = "List of key permissions. Possible values are Backup, Create, Decrypt, Delete, Encrypt, Get, Import, List, Purge, Recover, Restore, Sign, UnwrapKey, Update, Verify, WrapKey, Release, Rotate, GetRotationPolicy and SetRotationPolicy"
}

variable "kv_secret_permissions" {
  type        = list(any)
  default     = ["Get", "Set", "List"]
  description = "List of secret permissions, must be one or more from the following: Backup, Delete, Get, List, Purge, Recover, Restore and Set"
}

variable "kv_storage_permissions" {
  type        = list(any)
  default     = ["Get"]
  description = "List of storage permissions, must be one or more from the following: Backup, Delete, DeleteSAS, Get, GetSAS, List, ListSAS, Purge, Recover, RegenerateKey, Restore, Set, SetSAS and Update"
}

variable "kv_certificate_permissions" {
  type        = list(any)
  default     = ["Create", "Get", "List", "Delete", "Import", "Recover"]
  description = "List of certificate permissions, must be one or more from the following: Backup, Create, Delete, DeleteIssuers, Get, GetIssuers, Import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers and Update."
}

variable "kv_enabled_for_deployment" {
  type        = bool
  default     = false
  description = "Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault."
}

variable "kv_public_network_access_enabled" {
  type        = bool
  default     = false
  description = "Whether public network access is allowed for this Key Vault. Defaults to false."
}

variable "kv_private_endpoint_ip" {
  type        = string
  description = "IP Address for the Key Vault Private Endpoint."
}

variable "kv_administrator_objectid" {
  type        = string
  default     = null
  description = "ObjectID for administrator to upload certifiate manually."
}

#############################x
### App Service Plan Vars ###
#############################

variable "asp_os_type" {
  type        = string
  default     = "Linux"
  description = "OS type of the app service plan"
}

variable "asp_hosting_plan_sku" {
  type        = string
  default     = "P1v2"
  description = "App Service Plan SKU"
}

variable "asp_workers" {
  type        = string
  description = "App service Workers"
  default     = 1
}

####################################
### MySQL - Flexible Server Vars ###
####################################

variable "mfs_server_username" {
  type        = string
  description = "DB Server Username"
  default     = "dbadmusr"
}

variable "mfs_server_name" {
   type   = string
   description = "DB Server Name"
   default = "crbatmo-esp-d-em28-msql-dbserver"
}

variable "mfs_db_storage_size_gb" {
  type        = string
  description = "SQL DB Storage Size"
  default     = "128"
}

variable "mfs_db_storage_iops" {
  type        = string
  description = "SQL DB Storage IOPS"
  default     = "700"
}

variable "mfs_db_storage_autogrow" {
  type        = bool
  description = "SQL DB Storage Autogrow"
  default     = true
}

variable "mfs_db_database_version" {
  type        = string
  description = "SQL DB Version"
  default     = "8.0.21"
}

variable "mfs_db_database_backup_retention_days" {
  type        = string
  description = "how long to keep MySQL backup"
  default     = "7"
}

variable "mfs_db_database_georedundant_backup" {
  type        = string
  description = "Geo-Redundant Backup Enabled"
  default     = "false"
}

variable "mfs_db_sql_sku" {
  type        = string
  description = "SQL SKU Size"
  default     = "GP_Standard_D2ds_v4"
}

variable "mfs_private_endpoint_ip" {
  type        = string
  default     = ""
  description = "Specifies the static IP address within the private endpoint subnet to be used for MySQL"
}