resource "azurerm_user_assigned_identity" "uai_common" {
  name                = "${lower(var.businessUnit)}-${var.applicationId}-${local.environment_single_char}-em28-common-uai"
  resource_group_name = data.azurerm_resource_group.this.name
  location            = data.azurerm_resource_group.this.location
}

#resource "azurerm_user_assigned_identity" "uai_app_gateway" {
#  name                = "${lower(var.businessUnit)}-${var.applicationId}-${local.environment_single_char}-em28-agw01-uai"
#  resource_group_name = var.resource_group_name
#  location            = var.location
#}
