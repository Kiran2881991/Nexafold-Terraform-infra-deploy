appId       = "hipc"
environment = "pground"

vnet_name           = "crb-hipc-fra-c-em28-vnet"
resource_group_name = "crb-hipc-fra-c-em28-rgrp"
location            = "francecentral"
tags = {
  "APP_ID" = "hipc"
}
#######################
### Storage Account ###
#######################

sa_account_tier                      = "Standard"
sa_account_replication_type          = "GRS"
sa_account_kind                      = "StorageV2"
sa_cross_tenant_replication_enabled  = false
sa_access_tier                       = "Hot"
sa_min_tls_version                   = "TLS1_2"
sa_allow_nested_items_to_be_public   = false
sa_infrastructure_encryption_enabled = true
sa_public_network_access_enabled     = false

sa_blob_private_endpoint_ip = "10.223.241.132"

#######################
###   Key Vault     ###
#######################

kv_private_endpoint_ip           = "10.223.241.133"
kv_administrator_objectid        = "344b017b-d74b-481a-811b-9266c7a7c87f" # TODO: Use ObjectID of an Entra group
kv_public_network_access_enabled = false

#############################
### MySQL Flexible Server ###
#############################

mfs_db_database_backup_retention_days = "7"
mfs_db_database_georedundant_backup   = "false"
mfs_db_database_version               = "8.0.21"
mfs_db_sql_sku                        = "GP_Standard_D2ds_v4"
mfs_db_storage_autogrow               = true
mfs_db_storage_iops                   = "700"
mfs_db_storage_size_gb                = "128"
mfs_server_name                       = "wp-app-dbserver"
mfs_server_username                   = "wpdbadmusr"
mfs_wordpress_database_name           = "wp-app-database"
mfs_private_endpoint_ip               = "10.223.241.136"

#############################
###   App Service Plan    ###
#############################

asp_hosting_plan_sku = "P1v2" # TODO: Find suitable lower environment SKU
asp_os_type          = "Linux"
asp_workers          = 1
