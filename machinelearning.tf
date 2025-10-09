esource "random_string" "mcitprefix_random" {
  length  = 6
  upper   = false
  special = false
}
variable "location"{
type=string
default="Canada Central"
}
variable "prefix" {
 type    = string
 default = "montrealitcollege"
}

resource "azurerm_resource_group" "mcitprefix_rg" {
  name     = "mcitrg"
  location = var.location
}

resource "azurerm_storage_account" "mcitprefix_sa" {
  name                         = "${var.prefix}sa${random_string.mcitprefix_random.result}"
  resource_group_name          = azurerm_resource_group.mcitprefix_rg.name
  location                     = azurerm_resource_group.mcitprefix_rg.location
  account_tier                 = "Standard"
  account_replication_type     = "LRS"
  allow_nested_items_to_be_public = false
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

resource "azurerm_machine_learning_workspace" "mcitprefix_ws" {
  name                        = "${var.prefix}-ws"
  location                    = azurerm_resource_group.mcitprefix_rg.location
  resource_group_name         = azurerm_resource_group.mcitprefix_rg.name
  storage_account_id          = azurerm_storage_account.mcitprefix_sa.id
  key_vault_id                = azurerm_key_vault.mcitprefix_kv.id
  application_insights_id     = azurerm_application_insights.mcitprefix_appi.id
  container_registry_id       = azurerm_container_registry.mcitprefix_acr.id
  public_network_access_enabled = true
  identity { type = "SystemAssigned" }
}

resource "azurerm_key_vault_access_policy" "mcitprefix_kv_policy" {
  key_vault_id = azurerm_key_vault.mcitprefix_kv.id
  tenant_id    = var.tenant_id
  object_id    = azurerm_machine_learning_workspace.mcitprefix_ws.identity[0].principal_id
  secret_permissions      = ["Get", "List", "Set", "Delete", "Purge", "Recover", "Backup", "Restore"]
  key_permissions         = ["Get", "Create", "Delete", "List"]
  certificate_permissions = ["Get", "List"]
}

resource "azurerm_machine_learning_compute_cluster" "mcitprefix_cpu" {
  name                          = "${var.prefix}-cpu"
  location                      = azurerm_resource_group.mcitprefix_rg.location
  machine_learning_workspace_id = azurerm_machine_learning_workspace.mcitprefix_ws.id

  vm_size     = "STANDARD_DS3_V2"
  vm_priority = "Dedicated"         

  scale_settings {
    min_node_count                         = 0
    max_node_count                         = 1
    scale_down_nodes_after_idle_duration   = "PT15M" 
  }
}
output "resource_group_name" { value = azurerm_resource_group.mcitprefix_rg.name }
output "workspace_name"      { value = azurerm_machine_learning_workspace.mcitprefix_ws.name }
output "workspace_id"        { value = azurerm_machine_learning_workspace.mcitprefix_ws.id }
