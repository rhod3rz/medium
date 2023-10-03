# Create keyvault.
module "az_keyvault" {
  source              = "./modules/az_keyvault"                                          # The path to the module.
  location            = var.location                                                     # The location.
  resource_group_name = azurerm_resource_group.rg.name                                   # The resource group.
  keyvault_name       = "kv-${var.environment}-${var.application_code}-${var.unique_id}" # Keyvault name.
}

# Create keyvault access policies for the aks agentpool uai.
resource "azurerm_key_vault_access_policy" "kvap_agentpool" {
  depends_on              = [module.az_keyvault]
  key_vault_id            = module.az_keyvault.keyvault_id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = module.az_aks.aks_uai_agentpool_object_id
  key_permissions         = ["Get"]
  secret_permissions      = ["Get"]
  certificate_permissions = ["Get"]
}

# Create keyvault access policies for your user account and the terraform service principal.
resource "azurerm_key_vault_access_policy" "kvap_admin_users" {
  depends_on              = [module.az_keyvault]
  for_each                = { for my_kv in var.keyvault_policies : my_kv.access_policy_name => my_kv }
  key_vault_id            = module.az_keyvault.keyvault_id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = each.value.object_id
  key_permissions         = try(each.value.key_permissions, [])
  secret_permissions      = try(each.value.secret_permissions, [])
  certificate_permissions = try(each.value.certificate_permissions, [])
}

# Create a sample secret so we have something to retrieve later.
resource "azurerm_key_vault_secret" "kvs_username" {
  depends_on   = [module.az_keyvault, resource.azurerm_key_vault_access_policy.kvap_admin_users]
  name         = "titan-username"
  value        = "bart_simpson"
  key_vault_id = module.az_keyvault.keyvault_id
}

# Create a sample secret so we have something to retrieve later.
resource "azurerm_key_vault_secret" "kvs_password" {
  depends_on   = [module.az_keyvault, resource.azurerm_key_vault_access_policy.kvap_admin_users]
  name         = "titan-password"
  value        = "C0ngr4tul4t10n5"
  key_vault_id = module.az_keyvault.keyvault_id
}