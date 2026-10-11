# Key Vault for secrets

resource "azurerm_key_vault" "key_vault_transfer" {
  name                = "kv-banktransaction-sid"
  location            = azurerm_resource_group.rm.location
  resource_group_name = azurerm_resource_group.rm.name
  sku_name            = "standard"
  tenant_id           = data.azurerm_client_config.current.tenant_id
}
