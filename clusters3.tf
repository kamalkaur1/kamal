variable "clusters3" {
  default = {
  mcit-aks-1  = { sku = "B1", node_count = 1 }
    mcit-aks-2 = { sku = "P1v3", node_count = 2 }
mcit-aks-3 = { sku = "P1v3",node_count = 3 }
  }

