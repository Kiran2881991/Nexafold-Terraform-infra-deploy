variable "appId" {
  type        = string
  description = "Application ID, 6 digit number"
}

variable "applicationId" {
  type        = string
  description = "Application ID, 6 digit number"
}

variable "environment" {
  type        = string
  description = "The environment the silos should be deployed into"
}

variable "businessUnit" {
  type        = string
  description = "Business Unit"
}

variable "location" {
  type        = string
  description = " Location where Terraform resources will be deployed"
}

variable "nsg_rules" {
  type = map(list(object({
    name                         = string
    priority                     = number
    direction                    = string
    access                       = string
    protocol                     = string
    source_port_ranges           = list(string)
    destination_port_ranges      = list(string)
    source_address_prefixes      = list(string)
    destination_address_prefixes = list(string)
  })))
  description = "Map of NSG Rules to create, key of object is part of name of resource"
}

#variable "sharedAppIds" {
#  type        = string
#  description = "List of all Application IDs, 6 digit numbers in a single string, separated with commas."

#  validation {
#    # Start of string must be six digits, followed by zero or more commas, space and sx more digits.
#    condition     = can(regex("^\\d{6}(,\\s*\\d{6})*$", var.sharedAppIds))
#    error_message = "This must be a single string with six digit numbers, separated with commas. For example '123456, 222333'"
#  }
#}

variable "subnets" {
  type = map(object({
    address_prefixes  = list(string)
    service_endpoints = optional(list(string))
  }))
  description = "Map of Subnets to create, Key of object is part of name of resource, KEY MUST BE ENV-SUFFIX"
}

variable "vnet_name" {
  type        = string
  description = "Name of the VNET in which subnets will be created. Used for data lookup."
}

variable "vnet_address_space" {
  type        = string
  description = "CIDR range for VNET address space."
  default     = null
}

variable "subnet_name" {
  type        = string
  description = "Name of the VNET in which subnets will be created. Used for data lookup."
}

variable "wa_vnet_name" {
  type        = string
  description = "vnet in which web app is deployed"
}
#variable "peered_environments" {
#  type        = set(string)
#  description = "Environments to peer to."
#}


#################
# APP GW Config #
#################

variable "vnet_rg_name" {
  type        = string
  description = "Name of the resource group in which the App GW VNET resides. Used for data lookup."
}

variable "deploy_app_gw" {
  type        = bool
  default     = false
  description = "Whether to deploy Application Gateway or not.  Should be set to false for initial deployment until a backend and SSL certificate is available."
}

# WAF_Medium, WAF_Large, or WAF_v2 for publicly accessible apps
variable "app_gw_sku_name" {
  type        = string
  description = "The Name of the SKU to use for the Application Gateway."
  default     = "WAF_v2"
}

# WAF or WAF_v2 for publicly accessible apps
variable "app_gw_sku_tier" {
  type        = string
  description = "The Tier of the SKU to use for the Application Gateway."
  default     = "WAF_v2"
}

# Minimum 2 for all production workloads is recommended. 1 instance is ok for non-prod
variable "app_gw_sku_capacity" {
  type        = number
  description = "(Optional) The Capacity of the SKU to use for this Application Gateway. "
  default     = 1
}

variable "app_gw_private_ip" {
  description = "The Private IP address to associate with the App Gateway."
  type        = string
}

variable "app_gw_rules" {
  description = "Map of objects to configure a rule, listeners and probes. The key is used to name various resources."
  type = map(object({
    rule_type                        = string
    rule_priority                    = number
    redirect_rule_priority           = number
    listener_hostname                = string
    backend_name                     = string
    backend_cookie_based_affinity    = optional(string, "Enabled")
    backend_port                     = optional(number, 443)
    backend_protocol                 = optional(string, "Https")
    backend_request_timeout          = optional(number, 30)
    backend_hostname                 = optional(string, null)
    ssl_certificate                  = optional(string)
    health_probe_interval            = optional(number, 30)
    health_probe_path                = optional(string, "/")
    health_probe_timeout             = optional(number, 30)
    health_probe_unhealthy_threshold = optional(number, 3)
    health_probe_port                = optional(number, 443)
    health_probe_status_codes        = optional(list(number), [200])

  }))
  default = {}
}

variable "backend_pools" {
  description = "Map of objects to configure backend pools."
  type = map(object({
    backend_pool_ips   = optional(list(string), null)
    backend_pool_fqdns = optional(list(string), null)

  }))
  default = {}
}

variable "ssl_certificates" {
  description = "Map of objects to configure SSL certificates."
  type = map(object({
    key_vault_secret_id = string
    # key_vault_certificate_name      = string
    # source_key_vault                = string
    # source_key_vault_resource_group = string
  }))
  default = {}
}


variable "app_gw_diagnostics_enabled" {
  type        = bool
  default     = true
  description = "Whether to enable logging and metrics for the Application Gateway to the Log Analytics Workspace"
}

variable "disabled_rule_groups" {
  type = map(object({
    disabled_rules = list(string)
  }))
  default = {}
}

###############################
### Log Analytics Workspace ###
###############################
variable "law_rg_name" {
  type    = string
  default = "DefaultResourceGroup-DEV-FC-WEU"
  description = "This is the default resource group of law of france central"
}

variable "law_sku" {
  type        = string
  default     = "PerGB2018"
  description = "Specifies the SKU of the Log Analytics Workspace. Possible values are PerNode, Premium, Standard, Standalone, Unlimited, CapacityReservation, and PerGB2018 (new SKU as of 2018-04-03). Defaults to PerGB2018"
}

variable "law_retention_in_days" {
  type        = number
  default     = 30
  description = "The workspace data retention in days. Possible values are either 7 (Free Tier only) or range between 30 and 730"
}

variable "law_allow_resource_only_permissions" {
  type        = bool
  default     = true
  description = "Specifies if the log Analytics Workspace allow users accessing to data associated with resources they have permission to view, without permission to workspace. Defaults to true"
}

variable "law_local_authentication_disabled" {
  type        = bool
  default     = false
  description = "Specifies if the log Analytics workspace should enforce authentication using Azure AD. Defaults to false"
}

variable "law_internet_ingestion_enabled" {
  type        = bool
  default     = true
  description = "Should the Log Analytics Workspace support ingestion over the Public Internet? Defaults to true"
}

variable "law_internet_query_enabled" {
  type        = bool
  default     = false
  description = "Should the Log Analytics Workspace support querying over the Public Internet? Defaults to true"
}

###################
# Monitor metrics #
###################

variable "action_group_name" {
  type        = string
  description = "The name given to the action group to asign metrics too"
  default     = "CriticalAlertsAction"
}

variable "action_group_short_name" {
  type        = string
  description = "The short name given to the action group to asign metrics too"
  default     = "p0action"
}

variable "alert_criteria" {
  type = object({
    alert_metric_name = string
    alert_aggregation = string
    alert_operator    = string
    alert_threshold   = string
  })
  default     = null
  description = "The criteria values that activates the alert"
}
variable "email_receiver" {
  type = object({
    name                    = string
    email_address           = string
    use_common_alert_schema = optional(bool, true)
  })
  default     = null
  description = "The details of the intended email reciever. Requries a name and email address."
}