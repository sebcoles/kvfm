resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_app_service_plan" "example_app" {
  name                = var.app_name
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = var.location

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "app_service" {
  name                = var.app_name
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = var.location
  app_service_plan_id = azurerm_app_service_plan.example_app.id
  enabled             = true
  https_only          = true

  app_settings = {
    JAM = "Jam"
  }

  site_config {
    dotnet_framework_version = "v5.0"
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_resource_group" "simple_key_vault_rg" {
  name     = var.resource_group.name
  location = var.resource_group.location

  tags = {
    Source = "Simple Key-Vault"
  }
}

resource "azurerm_key_vault" "simple_key_vault" {
  name                = var.keyvault.name
  location            = azurerm_resource_group.simple_key_vault_rg.location
  resource_group_name = azurerm_resource_group.simple_key_vault_rg.name
  tenant_id           = var.keyvault.tenant_id
  sku_name            = var.keyvault.sku_name
  access_policy {
    tenant_id = var.keyvault.tenant_id
    object_id = var.keyvault.object_id

    key_permissions    = var.keyvault.keys_permissions
    secret_permissions = var.keyvault.secrets_permissions
  }

  enabled_for_deployment          = var.keyvault.enabled_for_deployment
  enabled_for_disk_encryption     = var.keyvault.enabled_for_disk_encryption
  enabled_for_template_deployment = var.keyvault.enabled_for_template_deployment
}