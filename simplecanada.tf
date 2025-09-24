resource "azurerm_resource_group" "canada_rg" {
  name     = "wa-canada-rg-2"
  location = "Canada Central"

  tags = {
    environment = "dev"
    project     = "wa-canada-2"
  }
}

resource "azurerm_service_plan" "canada_linux_plan" {
  name                = "wa-canada-linux-plan-2"
  location            = azurerm_resource_group.canada_rg.location
  resource_group_name = azurerm_resource_group.canada_rg.name
  os_type             = "Linux"
  sku_name            = "B1"

  tags = {
    environment = "dev"
    project     = "wa-canada-2"
  }
}

locals {
  canada_map_simple = {
    for item in var.canada_items : item => item
  }
}

resource "azurerm_linux_web_app" "canada_apps_simple" {
  for_each            = local.canada_map_simple
  name                = "wa-canada-${each.value}"
  location            = azurerm_service_plan.canada_linux_plan.location
  resource_group_name = azurerm_resource_group.canada_rg.name
  service_plan_id     = azurerm_service_plan.canada_linux_plan.id

  site_config {
    always_on = false
  }

  app_settings = {
    COUNTRY = "canada"
    ITEM    = each.value
  }

  tags = {
    environment = "dev"
    project     = "wa-canada-2"
    item        = each.value
  }
}

output "canada_app_names" {
  value = [for app in azurerm_linux_web_app.canada_apps_simple : app.name]
}
