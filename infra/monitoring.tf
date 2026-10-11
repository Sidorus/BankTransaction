# Monitoring shared by all microservices and the function

resource "azurerm_log_analytics_workspace" "log_workspace" {
  name                = "log-banktransaction-westus2"
  location            = azurerm_resource_group.rm.location
  resource_group_name = azurerm_resource_group.rm.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_application_insights" "appinsights" {
  name                = "appi-banktransaction-westus2"
  location            = azurerm_resource_group.rm.location
  resource_group_name = azurerm_resource_group.rm.name
  workspace_id        = azurerm_log_analytics_workspace.log_workspace.id
  application_type    = "web"
}
