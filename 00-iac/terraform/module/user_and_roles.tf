resource "azurerm_user_assigned_identity" "alb_identity" {
  name                  = "${var.clusterName}-alb-identity"
  resource_group_name   = azurerm_resource_group.aks_lab.name
  location              = azurerm_resource_group.aks_lab.location
}

# Reader role for node resource group
resource "azurerm_role_assignment" "aks_rg_reader" {
  principal_id          = azurerm_user_assigned_identity.alb_identity.principal_id
  scope                 = azurerm_kubernetes_cluster.aks_lab.node_resource_group_id
  role_definition_id    = "/providers/Microsoft.Authorization/roleDefinitions/acdd72a7-3385-48ef-bd42-f606fba81ae7"
  principal_type        = "ServicePrincipal"
}

resource "azurerm_role_assignment" "rg_reader" {
  principal_id          = azurerm_user_assigned_identity.alb_identity.principal_id
  scope                 = azurerm_resource_group.aks_lab.id
  role_definition_id    = "/providers/Microsoft.Authorization/roleDefinitions/acdd72a7-3385-48ef-bd42-f606fba81ae7"
  principal_type        = "ServicePrincipal"
}

# Configuration Manager for App Gateway
resource "azurerm_role_assignment" "alb_cfg_mgr" {
  principal_id          = azurerm_user_assigned_identity.alb_identity.principal_id
  scope                 = azurerm_resource_group.aks_lab.id
  role_definition_name  = "AppGw for Containers Configuration Manager"
  #role_definition_id    = "/providers/Microsoft.Authorization/roleDefinitions/fbc52c3f-28ad-4303-a892-8a056630b8f1"
  principal_type        = "ServicePrincipal"
}

resource "azurerm_role_assignment" "app_gw_aks_node_group" {
  principal_id          = azurerm_user_assigned_identity.alb_identity.principal_id
  scope                 = azurerm_kubernetes_cluster.aks_lab.node_resource_group_id
  role_definition_name  = "AppGw for Containers Configuration Manager"
  #role_definition_id    = "/providers/Microsoft.Authorization/roleDefinitions/fbc52c3f-28ad-4303-a892-8a056630b8f1"
  principal_type        = "ServicePrincipal"
}

# Network Contributor
resource "azurerm_role_assignment" "alb_network_contrib" {
  principal_id          = azurerm_user_assigned_identity.alb_identity.principal_id
  scope                 = azurerm_subnet.agfc_subnet.id
  role_definition_name  = "Network Contributor"
  #role_definition_id    = "/providers/Microsoft.Authorization/roleDefinitions/4d97b98b-1d4f-4787-a291-c67834d212e7"
  principal_type        = "ServicePrincipal"
}

resource "azurerm_role_assignment" "network_aks_node_group" {
  principal_id          = azurerm_user_assigned_identity.alb_identity.principal_id
  scope                 = azurerm_kubernetes_cluster.aks_lab.node_resource_group_id
  role_definition_name  = "Network Contributor"
  #role_definition_id    = "/providers/Microsoft.Authorization/roleDefinitions/4d97b98b-1d4f-4787-a291-c67834d212e7"
  principal_type        = "ServicePrincipal"
}


# Federated credential for alb controller
resource "azurerm_federated_identity_credential" "alb_fic" {
  name                      = "azure-alb-fic"
  resource_group_name       = azurerm_resource_group.aks_lab.name
  parent_id                 = azurerm_user_assigned_identity.alb_identity.id

  issuer                    = azurerm_kubernetes_cluster.aks_lab.oidc_issuer_url
  subject                   = "system:serviceaccount:azure-alb-system:alb-controller-sa"
  audience                  = ["api://AzureADTokenExchange"]
}
