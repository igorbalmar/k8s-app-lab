resource "azurerm_resource_group" "aks_lab" {
  name     = var.clusterName
  location = var.clusterLocation
}

resource "azurerm_kubernetes_cluster" "aks_lab" {
  name                    = var.clusterName
  kubernetes_version      = var.kubernetesVersion
  location                = azurerm_resource_group.aks_lab.location
  resource_group_name     = azurerm_resource_group.aks_lab.name
  dns_prefix              = var.clusterName

  default_node_pool {
    name            = "default"
    node_count      = 1
    vm_size         = var.vmSize
  }

  identity {
    type = "SystemAssigned"
  }

  oidc_issuer_enabled         = true
  workload_identity_enabled   = true

  network_profile {
    network_plugin          = "azure"
    network_mode            = "transparent"
    network_plugin_mode     = "overlay"
    network_policy          = "cilium"
    network_data_plane      = "cilium"
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "spot_pool" {
  name                      = "spot"
  kubernetes_cluster_id     = azurerm_kubernetes_cluster.aks_lab.id
  vm_size                   = var.vmSize
  node_count                = 1
  priority                  = "Spot"
  eviction_policy           = "Delete"
  spot_max_price            = 0.5

  node_labels = {
    "kubernetes.azure.com/scalesetpriority" = "spot"
  }
}
