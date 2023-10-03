# Declare variables.
variable "location" {}
variable "resource_group_name" {}
variable "aks_name" {}
variable "subnet_aks" {}
variable "subnet_appgw" {}

# Create the aks cluster.
resource "azurerm_kubernetes_cluster" "kc" {
  location            = var.location
  resource_group_name = var.resource_group_name
  node_resource_group = "${var.resource_group_name}-nrg"
  name                = var.aks_name
  dns_prefix          = "${var.aks_name}-dns"

  # Set the default node pool config.
  default_node_pool {
    name           = "default"
    node_count     = "1"
    vm_size        = "Standard_B2s"
    vnet_subnet_id = var.subnet_aks # Nodes and pods will receive ip's from here.
  }

  # Set the identity profile.
  identity {
    type = "SystemAssigned"
  }

  # Set the network profile.
  network_profile {
    network_plugin = "azure"
  }

  # Install application gateway.
  # Note: you MUST add a tweak to give the auto-created ingress uai the contributor iam role on the subnet or vnet; see tweak 1.
  # Note: it's normal for the pod/ingress-appgw-deployment to restart / crashloopbackoff whilst it's deploying agic.
  # Note: it can take ~15-20 mins for the agw to install; monitor pod/ingress-appgw-deployment logs for errors and progress.
  ingress_application_gateway {
    subnet_id = var.subnet_appgw
  }

}

# Required for helm provider config.
output "aks_config" { value = azurerm_kubernetes_cluster.kc.kube_config }

# Required to set access policy on key vault.
output "aks_uai_agentpool_object_id" { value = azurerm_kubernetes_cluster.kc.kubelet_identity[0].object_id }

# Required when setting up csi driver secret provier class.
output "aks_uai_agentpool_client_id" { value = azurerm_kubernetes_cluster.kc.kubelet_identity[0].client_id }

# Required to set IAM role on appgw subnet.
output "aks_uai_appgw_object_id" { value = azurerm_kubernetes_cluster.kc.ingress_application_gateway[0].ingress_application_gateway_identity[0].object_id }
