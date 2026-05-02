variable "businessUnit" {
  type        = string
  description = "Business Unit"
}

variable "location" {
  type        = string
  description = " Location where Terraform resources will be deployed"
}

variable "applicationId" {
  type  = string
  description = "application short code"
}

variable "environmentSingleChar" {
  type  = string
  description = "Environment short code"
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

variable "appId" {
  type        = string
  description = "List of all Application IDs, 6 digit numbers in a single string, separated with commas."
}

variable "subnets" {
  type = map(object({
    address_prefixes  = list(string)
    service_endpoints = optional(list(string))
    delegations = optional(map(object({
      name    = string
      actions = list(string)
    })))
  }))
  description = "Map of Subnets to create, Key of object is part of name of resource, KEY MUST BE ENV-SUFFIX"
}

variable "vnet_name" {
  type        = string
  description = "Name of the VNET in which subnets will be created. Used for data lookup."
}

variable "vnet_address_space" {
  type    = list(string)
  description = "Address space of the vnet"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group in which the Networking resources should be deployed into. Used for data lookup."
}