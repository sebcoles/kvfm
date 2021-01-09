output "default_hostname" {
  value = azurerm_app_service.app_service.default_site_hostname
}

output "vault_uri" {
  value = azurerm_key_vault.simple_key_vault.vault_uri
}