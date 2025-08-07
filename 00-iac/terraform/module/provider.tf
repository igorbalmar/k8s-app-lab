terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

provider "azurerm" {
    features {
      resource_group {
        prevent_deletion_if_contains_resources = false
      }
    }

   subscription_id = var.subscriptionId
}

provider "helm" {
  kubernetes = {
    config_path = "~/.kube/config"
 
    exec = {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = [ "aks", "get-credentials", "--resource-group", var.clusterName, "--name", var.clusterName ]
      command     = "az"
    }
  }
}