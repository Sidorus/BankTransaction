# Service Bus for messages between the microservices

resource "azurerm_servicebus_namespace" "sb_transfer" {
  name                = "sb-banktransaction-westus2-sid"
  location            = azurerm_resource_group.rm.location
  resource_group_name = azurerm_resource_group.rm.name
  sku                 = "Standard" # Basic, Standard, Premium
}
