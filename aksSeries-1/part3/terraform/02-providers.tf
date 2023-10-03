#================================================================================================
# Provider Configuration
#================================================================================================

terraform {
  required_version = "~> 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
  }
}

provider "azurerm" {
  features {}
  tenant_id       = var.tenant_id
  client_id       = var.terraform_sp
  subscription_id = var.subscription_id
  # client_secret = Ensure $env:ARM_CLIENT_SECRET is set locally
}

provider "helm" {
  kubernetes {
    host                   = module.az_aks.aks_config[0].host
    client_certificate     = base64decode(module.az_aks.aks_config[0].client_certificate)
    client_key             = base64decode(module.az_aks.aks_config[0].client_key)
    cluster_ca_certificate = base64decode(module.az_aks.aks_config[0].cluster_ca_certificate)
  }
}

#================================================================================================
# Backend Configuration
#================================================================================================

terraform {
  backend "azurerm" {
    storage_account_name = "saterraformstate2309" # UPDATE HERE.
    container_name       = "aks-series"           # UPDATE HERE.
    # key                = Specify via terraform init e.g. -backend-config="key=env-prd.tfstate"
    # access_key         = Ensure $env:ARM_ACCESS_KEY is set locally
  }
}
