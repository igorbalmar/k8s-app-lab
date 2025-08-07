resource "helm_release" "argocd" {
  chart             = "argo-cd"
  name              = "argocd"
  namespace         = "argocd"
  repository        = "https://argoproj.github.io/argo-helm"
  version           = var.argoVersion
  create_namespace  = true

  depends_on        = [
    azurerm_kubernetes_cluster.aks_lab
    ]
}

resource "helm_release" "argo_rollouts" {
  name              = "argo-rollouts"
  namespace         = "argocd"
  repository        = "https://argoproj.github.io/argo-helm"
  chart             = "argo-rollouts"
  create_namespace  = true

  depends_on        = [
    azurerm_kubernetes_cluster.aks_lab
  ]

}