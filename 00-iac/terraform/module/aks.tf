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
    name                          = "default"
    max_count                     = var.maxNodes
    min_count                     = 1
    vm_size                       = var.vmSize
    vnet_subnet_id                = azurerm_subnet.aks_subnet.id
    auto_scaling_enabled          = var.autoscaling
    temporary_name_for_rotation   = "temporary"
    
    upgrade_settings {
      drain_timeout_in_minutes      = 0
      max_surge                     = "50%" 
      node_soak_duration_in_minutes = 0
    }
    
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
