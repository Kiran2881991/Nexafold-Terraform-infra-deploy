appId       = "006525"
environment = "uat"

vnet_name           = "crbatmo-esp-u-em28-vnet"
resource_group_name = "crbatmo-esp-u-em28-rgrp"
location            = "francecentral"
tags = {
  "APP_ID"      = "006525",
  "Application" = "escape-v2"
}

####################
###   Web App    ###
####################

wa_alwayson            = true
wa_docker_registry_url = "https://mcr.microsoft.com"
#wa_private_endpoint_ip = "10.223.213.135"

#########################
###   Wordpress App   ###
#########################

wp_admin_admin_user_name      = ""
wp_admin_email                = ""
wp_container_linux_fx_version = "appsvc/wordpress-debian-php:8.3"
wp_container_start_time_limit = "900"
wp_default_site_title         = "WordPress On Azure App services"
wp_locale_code                = "en_US"
wp_setup_phpadmin             = "true"