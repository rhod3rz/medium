# Declare variables.
variable "location" {}
variable "resource_group_name" {}
variable "keyvault_name" {}

# Get the terraform service principal config.
data "azurerm_client_config" "current" {}

# Create a keyvault.
resource "azurerm_key_vault" "kv" {
  name                       = var.keyvault_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = "7"
  purge_protection_enabled   = false
}

# Required to set keyvault access policies.
output "keyvault_id" { value = azurerm_key_vault.kv.id }