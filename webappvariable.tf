variable "canada_items" {
  description = "Last-word items for Canada (Linux web apps)"
  type        = list(string)
  default = [
    "mapleleaf", "hockey", "poutine", "mountie", "niagara",
    "timhortons", "beavertail", "loonie", "canoe", "igloo"
  ]
}
variable "us_items" {
  description = "Last-word items for US (Windows web apps)"
  type        = list(string)
  default = [
    "burger", "baseball", "jeans", "hollywood", "donut",
    "jazz", "applepie", "football", "route66", "hotdog"
  ]
}

variable "project_prefix" {
  description = "Prefix for resource names"
  type        = string
  default     = "wa"
}

#############################
# Resource Group
#############################
resource "azurerm_resource_group" "rg" {
  name     = "${var.project_prefix}-rg"
  location = "Canada Central" # RG location can differ from resources
  tags = {
    environment = "dev"
    project     = var.project_prefix
  }
}

#############################
# App Service Plans
#############################
# Linux plan in Canada Central
resource "azurerm_service_plan" "linux_plan_canada" {
  name                = "${var.project_prefix}-linux-plan-ca"
  location            = "Canada Central"
  resource_group_name = azurerm_resource_group.rg.name

  os_type  = "Linux"
  sku_name = "P1v3" # production-ready tier; adjust as needed
  tags = {
    environment = "dev"
    project     = var.project_prefix
  }
}

# Windows plan in East US
resource "azurerm_service_plan" "windows_plan_us" {
  name                = "${var.project_prefix}-win-plan-us"
  location            = "East US"
  resource_group_name = azurerm_resource_group.rg.name

  os_type  = "Windows"
  sku_name = "P1v3"
  tags = {
    environment = "dev"
    project     = var.project_prefix
  }
}

#############################
# Random suffix to ensure global uniqueness of app names
#############################
resource "random_string" "suffix" {
  length  = 5
  upper   = false
  special = false
}

#############################
# Linux Web Apps for Canada items
#############################
# Build a map: key = item, value = normalized name part
locals {
  canada_map = {
    for item in var.canada_items :
    item => replace(item, "/[^a-zA-Z0-9-]/", "")
  }
}

resource "azurerm_linux_web_app" "canada_apps" {
  for_each            = local.canada_map
  name                = "${var.project_prefix}-canada-${each.value}-${random_string.suffix.result}"
  location            = azurerm_service_plan.linux_plan_canada.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.linux_plan_canada.id

  site_config {
    # Minimal config; add application_stack as needed (node_version, python_version, etc.)
    always_on = true
  }

  app_settings = {
    COUNTRY = "canada"
    ITEM    = each.key
    PREFIX  = "wa-canada-${each.key}"
  }

  tags = {
    environment = "dev"
    project     = var.project_prefix
    country     = "canada"
    item        = each.key
    os          = "linux"
  }
}

#############################
# Windows Web Apps for US items
#############################
locals {
  us_map = {
    for item in var.us_items :
    item => replace(item, "/[^a-zA-Z0-9-]/", "")
  }
}

resource "azurerm_windows_web_app" "us_apps" {
  for_each            = local.us_map
  name                = "${var.project_prefix}-us-${each.value}-${random_string.suffix.result}"
  location            = azurerm_service_plan.windows_plan_us.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.windows_plan_us.id

  site_config {
    always_on = true
    # Optionally set stack versions here (e.g., dotnet_framework_version) if needed
  }

  app_settings = {
    COUNTRY = "us"
    ITEM    = each.key
    PREFIX  = "wa-us-${each.key}"
  }

  tags = {
    environment = "dev"
    project     = var.project_prefix
    country     = "us"
    item        = each.key
    os          = "windows"
  }
}

#############################
# Useful outputs
#############################
output "canada_linux_app_urls" {
  description = "Linux app default hostnames (Canada)"
  value       = [for app in azurerm_linux_web_app.canada_apps : "https://${app.default_hostname}"]
}

output "us_windows_app_urls" {
  description = "Windows app default hostnames (US)"
  value       = [for app in azurerm_windows_web_app.us_apps : "https://${app.default_hostname}"]
}

output "app_names" {
  value = {
    canada = [for app in azurerm_linux_web_app.canada_apps : app.name]
    us     = [for app in azurerm_windows_web_app.us_apps : app.name]
  }
}
