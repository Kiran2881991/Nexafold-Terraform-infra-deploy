appId       = "006525"
environment = "dev"
businessunit = "crbatmo"
applicationId = "esp"
resource_group_name = "crbatmo-esp-d-em28-rgrp"
location            = "francecentral"
vnet_name           = "crbatmo-esp-d-em28-vnet"
#vnet_address_space  = ["10.80.4.0/24"]
vnet_address_space  = ["10.223.244.0/24"]
subnet_name         = "crbatmo-esp-appservice-d-em28-subn1"
#subnet_address_space = ["10.80.4.128/26"]
subnet_address_space = ["10.223.244.0/26"]

tags = {
  "AppID"      = "006525"
  "Application" = "escape-v2"
}

# Web App
wa_alwayson            = true
wa_docker_registry_url = "https://mcr.microsoft.com"
wa_pe_subnet_name      = "crbatmo-esp-privateendpoint-d-em28-subn1"
wa_private_endpoint_ip = "10.223.244.135"

# PHP App
php_admin_user_name            = ""
php_admin_email                = ""
php_container_linux_fx_version = "appsvc/php:8.0-fpm" # Official PHP image
php_container_start_time_limit = "900"
php_default_site_title         = "PHP App On Azure App Service"
php_locale_code                = "en_US"
php_setup_phpadmin             = "true"