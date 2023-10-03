# Create kubernetes cluster.
module "az_aks" {
  source              = "./modules/az_aks"                                                # The path to the module.
  location            = var.location                                                      # The location.
  resource_group_name = azurerm_resource_group.rg.name                                    # The resource group.
  aks_name            = "aks-${var.environment}-${var.application_code}-${var.unique_id}" # The AKS cluster name.
  subnet_aks          = azurerm_subnet.subnet_aks.id                                      # The AKS subnet id.
  subnet_appgw        = azurerm_subnet.subnet_appgw.id                                    # The appgw subnet id.
}