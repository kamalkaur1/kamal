variable "plans1" {
  default = {
   rg-dev  = { sku = "B1", worker_count = 1 }
    rg-test= { sku = "P1v3", worker_count = 2 }
rg-prod= { sku = "P1v3", worker_count = 3 }
  }
}
 
resource "azurerm_service_plan" "asp" {
  for_each            = var.plans1
  name                = "asp-${each.key}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = each.value.sku
  worker_count        = each.value.worker_count
}
