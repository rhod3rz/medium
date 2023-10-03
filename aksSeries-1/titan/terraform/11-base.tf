# Create a resource group.
resource "azurerm_resource_group" "rg" {
  location = var.location
  name     = "rg-${var.environment}-${var.application_code}-${var.unique_id}"
}

# Create a vnet.
resource "azurerm_virtual_network" "vn" {
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  name                = "vnet-aks"
  address_space       = ["192.168.0.0/16"]
}

# Create a subnet for aks nodes and pods.
resource "azurerm_subnet" "subnet_aks" {
  resource_group_name  = azurerm_resource_group.rg.name
  name                 = "snet-aks"
  virtual_network_name = azurerm_virtual_network.vn.name
  address_prefixes     = ["192.168.1.0/24"]
}

# Create a subnet for application gateway.
resource "azurerm_subnet" "subnet_appgw" {
  resource_group_name  = azurerm_resource_group.rg.name
  name                 = "snet-appgw"
  virtual_network_name = azurerm_virtual_network.vn.name
  address_prefixes     = ["192.168.2.0/24"]
}