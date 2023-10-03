# Create kubernetes cluster tweaks.
module "az_aks_tweaks" {

  depends_on = [module.az_aks]           # Wait for dependencies.
  source     = "./modules/az_aks_tweaks" # The path to the module.

  # Tweak 1 - set 'contributor' role assignment for the auto-created 'ingressapplicationgateway' uai on the appgw vnet; otherwise it can't manage ingress.
  tw1_aks_vnet_id             = azurerm_virtual_network.vn.id         # The aks vnet id.
  tw1_aks_uai_appgw_object_id = module.az_aks.aks_uai_appgw_object_id # The client_id for the auto-created 'ingressapplicationgateway' uai .

}
