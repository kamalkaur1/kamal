






variable "clusters3" {
  default = {
   cluster1  = { cidr_block = "10.0.0.0/16", node_count = 1 }
    cluster1 = { cidr_block = "10.1.0.0/16", node_count = 2 }
cluster1 = { cidr_block = "10.2.0.0/16", node_count = 3 }
  }
}


resource "nameof3clusters" "CLUSTER" {
  for_each            = var.clusters3
  name                = "asp-${each.key}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = each.value.cidr_block
  worker_count        = each.value.node_count
}





