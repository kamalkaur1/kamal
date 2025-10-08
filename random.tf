variable "prefix" {
 type    = string
 default = "montrealitcollege"
}

resource "random_string" "mcitprefix_random" {
 length  = 6
 upper   = false
 special = false
}
resource "azurerm_resource_group" "mcitprefix_rg" {
 name     = "mcitrg"
 location = var.location
}
resource "azurerm_storage_account" "mcitprefix_sa" {
 name                     = "${var.prefix}sa${random_string.mcitprefix_random.result}"
 resource_group_name      = azurerm_resource_group.mcitprefix_rg.name
 location                 = azurerm_resource_group.mcitprefix_rg.location
 account_tier             = "Standard"
 account_replication_type = "LRS"
}
resource "azurerm_key_vault" "mcitprefix_kv" {
 name                       = "${var.prefix}-kv"
 resource_group_name        = azurerm_resource_group.mcitprefix_rg.name
 location                   = azurerm_resource_group.mcitprefix_rg.location
 tenant_id                  = var.tenant_id
 sku_name                   = "standard"
 purge_protection_enabled   = true
 soft_delete_retention_days = 7
}
resource "azurerm_application_insights" "mcitprefix_appi" {
 name                = "${var.prefix}-appi"
 location            = azurerm_resource_group.mcitprefix_rg.location
 resource_group_name = azurerm_resource_group.mcitprefix_rg.name
 application_type    = "web"
}
resource "azurerm_container_registry" "mcitprefix_acr" {
 name                = "${var.prefix}acr${random_string.mcitprefix_random.result}"
 resource_group_name = azurerm_resource_group.mcitprefix_rg.name
 location            = azurerm_resource_group.mcitprefix_rg.location
 sku                 = "Basic"
 admin_enabled       = true
}
