

variable "clusters3" {
  default = {
    mcit-aks-1  = { sku = "standard", nodecount = "1" }
  mcit-aks-2 = { sku = "Premium", nodecount ="2" }
mcit-aks-3 = { sku = "basic",nodecount = "3"  } 
   
}

resource "cluster" "this" {
  for_each = var.clusters3

  name     = each.key
  version  = each.value.nodecount
 
  
  }
}
