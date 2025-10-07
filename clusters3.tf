variable "clusters3" {
  default = {
  mcit-aks-1  = { sku = "B1", node_count = 1 }
    mcit-aks-2 = { sku = "P1v3", node_count = 2 }
mcit-aks-3 = { sku = "P1v3",node_count = 3 }
  }
}
resource "azurerm_container_registry" "containers" {
  for_each            = var.clusters3
  name                = "${each.key}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
    sku      = each.value.sku
 }
