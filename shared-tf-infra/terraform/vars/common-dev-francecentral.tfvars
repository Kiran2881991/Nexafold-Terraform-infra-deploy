appId       = "006525"
applicationId = "esp"
environment = "dev"
environmentSingleChar = "d"
businessUnit = "CRBATMO"
location     = "francecentral"
vnet_name    = "crbatmo-esp-d-em28-vnet"
# vnet_address_space = ["10.80.4.0/24"]
resource_group_name = "crbatmo-esp-d-em28-rgrp"
tags = {
  "AppID" = "006525"
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
#sa_blob_private_endpoint_ip = "10.80.4.4"
sa_blob_private_endpoint_ip = "10.223.244.132"

#######################
###   Key Vault     ###
#######################

#kv_private_endpoint_ip           = "10.80.4.5"
kv_private_endpoint_ip           = "10.223.244.133"
kv_administrator_objectid        = "015f14d5-10a6-4e20-9b48-2bc6f680a7b2" # TODO: Use ObjectID of an Entra group- I used R-AZC-ITC-France-CRB-ALL-SUB-Owners
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
mfs_server_name                       = "crbatmo-esp-d-em28-msql-dbserver"
mfs_server_username                   = "dbadmusr"
#mfs_app_database_name                 = "esp-d-em28-app-db"
#mfs_private_endpoint_ip               = "10.80.4.6"
mfs_private_endpoint_ip               = "10.223.244.134"

#############################
###   App Service Plan    ###
#############################

asp_hosting_plan_sku = "P0v3" # TODO: Find suitable lower environment SKU
asp_os_type          = "Linux"
asp_workers          = 1
