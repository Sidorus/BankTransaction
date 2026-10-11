# Values shown after apply; read them any time with: terraform output

# Microservice URLs
output "apigateway_url" {
  value = "https://${azurerm_linux_web_app.appservice-apigateway.default_hostname}"
}

output "transaction_url" {
  value = "https://${azurerm_linux_web_app.appservice-transaction.default_hostname}"
}

output "balance_url" {
  value = "https://${azurerm_linux_web_app.appservice-balance.default_hostname}"
}

output "transfer_url" {
  value = "https://${azurerm_linux_web_app.appservice-transfer.default_hostname}"
}

output "notification_url" {
  value = "https://${azurerm_linux_web_app.appservice-notification.default_hostname}"
}

# Dead-letter function: name for "func azure functionapp publish", identity for granting access
output "function_deadletter_name" {
  value = azurerm_function_app_flex_consumption.function_deadletter.name
}

output "function_deadletter_principal_id" {
  value = azurerm_function_app_flex_consumption.function_deadletter.identity[0].principal_id
}

# Data and messaging endpoints
output "sql_server_fqdn" {
  description = "Server name for SSMS / connection strings"
  value       = azurerm_mssql_server.sql_server.fully_qualified_domain_name
}

output "cosmosdb_endpoint" {
  value = azurerm_cosmosdb_account.cosmosdb_account_notification.endpoint
}

output "servicebus_endpoint" {
  value = azurerm_servicebus_namespace.sb_transfer.endpoint
}

output "key_vault_uri" {
  value = azurerm_key_vault.key_vault_transfer.vault_uri
}

output "appinsights_connection_string" {
  value     = azurerm_application_insights.appinsights.connection_string
  sensitive = true
}
