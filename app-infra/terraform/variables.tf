variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be deployed"
  type        = string
}

variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "vnet_address_space" {
  description = "The address space for the virtual network"
  type        = list(string)
}

variable "subnet_name" {
  description = "subnet name to added in Vnet"
  type = string
}

variable "subnet_address_space" {
  description = "The address space for the default subnet"
  type        = list(string)
}

variable "wa_pe_subnet_name" {
  description = "web app private endpoint subnet name"
  type = string
}

variable "appId" {
  type        = string
  description = "Application ID, 6 digit number"
}

variable "applicationId" {
  type        = string
  description = "Applications short Name"
  default = "esp"
}

variable "businessunit" {
  type        = string
  description = "crbatmo"
}

variable "environment" {
  type        = string
  description = "The environment the silos should be deployed into"
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

################################
### App Service Web App Vars ###
################################

variable "wa_alwayson" {
  type        = bool
  description = "App service Always On"
  default     = true
}

variable "wa_docker_registry_url" {
  type        = string
  description = "Docker Registry URL"
  default     = "mcr.microsoft.com"
}

variable "wa_private_endpoint_ip" {
  type        = string
  default     = ""
  description = "Specifies the static IP address within the App Service private endpoint's subnet to be used"
}

#######################
### PHP App Vars ###
#######################

variable "php_admin_email" {
  type        = string
  description = "PHP App admin email"
}

variable "php_admin_user_name" {
  type        = string
  description = "PHP App admin user"
}

variable "php_default_site_title" {
  type        = string
  description = "Default site title for the PHP App"
  default     = "PHP App On Azure App Service"
}

variable "php_locale_code" {
  type        = string
  description = "Locale Code for the PHP App"
  default     = "en_US"
}

variable "php_container_linux_fx_version" {
  type        = string
  description = "Container image version for PHP"
  default     = "appsvc/php:8.0-fpm"
}

variable "php_container_start_time_limit" {
  type        = string
  description = "Container start time limit for PHP"
  default     = "900"
}

variable "php_setup_phpadmin" {
  type        = string
  description = "Enable phpMyAdmin setup for new PHP App deployments"
  default     = "true"
}
