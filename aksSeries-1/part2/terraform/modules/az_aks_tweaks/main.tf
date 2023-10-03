# Tweak 1
variable "tw1_aks_vnet_id" {}
variable "tw1_aks_uai_appgw_object_id" {}
resource "azurerm_role_assignment" "contributor-to-aks-ingress-on-appgw-vnet" {
  scope                = var.tw1_aks_vnet_id
  role_definition_name = "Contributor"
  principal_id         = var.tw1_aks_uai_appgw_object_id
}
