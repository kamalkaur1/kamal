variable "webapp_names" {
  type    = list(string)
  default = ["app1", "app2", "app3", "app4", "app5"]
}

resource "azurerm_resource_group" "mcitazurerm" {
  name     = "septemberazurerm"
  location = "Canada Central"
}

resource "azurerm_service_plan" "mcitsplan" {
  name                = "mcitserviceplan"
  resource_group_name = azurerm_resource_group.mcitazurerm.name
  location            = azurerm_resource_group.mcitazurerm.location
  os_type             = "Linux"
  sku_name            = "P1v2"
}


resource "azurerm_linux_web_app" "mcitlinuxwebapp" {
  for_each            = toset(var.webapp_names)
  name                = each.key
  resource_group_name = azurerm_resource_group.mcitazurerm.name
  location            = azurerm_resource_group.mcitazurerm.location
  service_plan_id     = azurerm_service_plan.mcitsplan.id

  site_config {}
}
