variable "location" {
  description = "Région Azure"
  type        = string
  default     = "Canada Central"
}

 
variable "vnet_name" {
  description = "Nome of virtual Network"
  type        = string
  default     = "kamal"
}

 
 
variable "subnet_name" {
  description = "Nome of subnet"
  type        = string
  default     = "kamal"
}

 
variable "vnet_address_space" {
  description = "Liste des plages d'adresses CIDR pour le VNet"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}
 
 
variable "subnet_address_prefixes" {
  description = "Liste des plages d'adresses CIDR pour le subnet"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

 
variable "storage_account_names" {
  description = "Noms des 10 comptes de stockage"
  type        = list(string)
  default     = [
    "kamal1", "kamal2", "kamal3", "kamal4", "kamal5",
    "kamal6", "kamal7", "kamal8", "kamal9", "kamal10"
  ]
}
 
####Ressources
 
resource "azurerm_resource_group" "kamal_rg" {
  name     = "kamal-rg"
  location = var.location
}

 
resource "azurerm_virtual_network" "kamal_vnet" {
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  location            = var.location
  resource_group_name = azurerm_resource_group.kamal_rg.name
}
 
resource "azurerm_subnet" "kamal_subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.kamal_rg.name
  virtual_network_name = azurerm_virtual_network.kamal_vnet.name
  address_prefixes     = var.subnet_address_prefixes
}
 
resource "azurerm_storage_account" "kamal_storage" {
  for_each                 = toset(var.storage_account_names)
  name                     = each.value
  resource_group_name      = azurerm_resource_group.kamal_rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  min_tls_version          = "TLS1_2"
 
  network_rules {
    default_action             = "Deny"
    bypass                     = ["AzureServices"]
    virtual_network_subnet_ids = [azurerm_subnet.kamal_subnet.id]
  }
}
 
