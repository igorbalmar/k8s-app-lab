module "aks" {
  source                = "./module"
  clusterName           = "challenge"
  clusterLocation       = "East US"
  kubernetesVersion     = "1.33"
  vmSize                = "Standard_A2_v2"
  subscriptionId        = "f4b29925-415a-4506-8a73-6992820c05bb"
}