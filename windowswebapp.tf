

resource "azurerm_resource_group" "kaur" {
  name     = "mcitkaur"
  location = "West Europe"
}

resource "azurerm_service_plan" "kaurserviceplan" {
  name                = "kaurplan"
  resource_group_name = azurerm_resource_group.kaur.name
  location            = azurerm_resource_group.kaur.location
  sku_name            = "P1v2"
  os_type             = "Windows"
}

resource "azurerm_windows_web_app" "kaurwebapp" {
  name                = "example"
  resource_group_name = azurerm_resource_group.kaur.name
  location            = azurerm_service_plan.kaur.location
  service_plan_id     = azurerm_service_plan.kaur.id

  site_config {}
}
