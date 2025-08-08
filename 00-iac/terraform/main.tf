module "aks" {
  source                = "./module"
  clusterName           = "challenge"
  clusterLocation       = "East US"
  kubernetesVersion     = "1.33"
  vmSize                = "Standard_A2_v2"
  subscriptionId        = "f4b29925-415a-4506-8a73-6992820c05bb"
  albVersion            = "1.7.9"
  argoVersion           = "5.19.12"
  autoscaling           = true
  maxNodes              = 4
}