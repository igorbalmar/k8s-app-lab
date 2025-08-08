# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                  = "${var.clusterName}-vnet"
  location              = azurerm_resource_group.aks_lab.location
  resource_group_name   = azurerm_resource_group.aks_lab.name
  address_space         = ["10.1.0.0/16"]
}

# Subnet delegated for AGFC
resource "azurerm_subnet" "agfc_subnet" {
  name                  = "${var.clusterName}-agfc-subnet"
  resource_group_name   = azurerm_resource_group.aks_lab.name
  virtual_network_name  = azurerm_virtual_network.vnet.name
  address_prefixes      = ["10.1.1.0/24"]

  delegation {
    name = "delegation"
    service_delegation {
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
      name = "Microsoft.ServiceNetworking/trafficControllers"
    }
  }
}

#aks subnet
resource "azurerm_subnet" "aks_subnet" {
  name                    = "aks-subnet"
  resource_group_name     = azurerm_resource_group.aks_lab.name
  virtual_network_name    = azurerm_virtual_network.vnet.name
  address_prefixes        = ["10.1.2.0/24"]

}