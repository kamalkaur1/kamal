resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}
resource "azurerm_container_registry" "example" {
  name                = "containerRegistry1"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                 = "Premium"
}
resource "azurerm_kubernetes_cluster" "example" {
  name                = "example-aks1"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  dns_prefix          = "exampleaks1"
  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }
  identity {
    type = "SystemAssigned"
  }
  tags = {
    Environment = "Production"
  }

}


variable "clusters3" {
  default = {
   mcit-aks-1  ={ sku = "B1", node_count = 1 }
  mcit-aks-2 ={ sku = "P1v3", node_count = 2 }
"mcit-aks-1={ sku = "P1v3", node_count = 3 }
  }
}
 
resource "azurerm_registry" "asp2" {
  for_each            = var.clusters3
  name                = "asp2-${each.key}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
    worker_count        = each.value.node_count
}
resource "azurerm_role_assignment" "clusters3" {
  principal_id                     = azurerm_kubernetes_cluster.clusters3.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.3clusters.id
  skip_service_principal_aad_check = true
}
 
