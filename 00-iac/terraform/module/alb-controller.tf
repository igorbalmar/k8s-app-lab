resource "helm_release" "alb_controller" {
  name                  = "alb-controller"
  repository            = ""
  chart                 = "oci://mcr.microsoft.com/application-lb/charts/alb-controller"
  namespace             = "azure-alb-system"
  create_namespace      = true
  version               = var.albVersion

set = [
    {
      name  = "albController.namespace"
      value = "azure-alb-system"
    },
    {
      name  = "albController.podIdentity.clientID"
      value = azurerm_user_assigned_identity.alb_identity.client_id
    },
    {
      name  = "service.type"
      value = "ClusterIP"
    }
  ]

  depends_on = [
    azurerm_role_assignment.alb_cfg_mgr, 
    azurerm_role_assignment.alb_network_contrib,
    azurerm_kubernetes_cluster.aks_lab
  ]
}