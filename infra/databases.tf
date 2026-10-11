# SQL server shared by the services, one database per service

resource "azurerm_mssql_server" "sql_server" {
  name                         = "sqlserver-banktransaction-westus2-sid"
  resource_group_name          = azurerm_resource_group.rm.name
  location                     = azurerm_resource_group.rm.location
  version                      = "12.0"
  administrator_login          = "adminuser"
  administrator_login_password = var.sql_admin_password
}

# Allows Azure services (the web apps) to reach the server
# resource "azurerm_mssql_firewall_rule" "allow_azure_services" {
#   name             = "AllowAzureServices"
#   server_id        = azurerm_mssql_server.sql_server.id
#   start_ip_address = "0.0.0.0"
#   end_ip_address   = "0.0.0.0"
# }

# Allows the local PC to reach the server
resource "azurerm_mssql_firewall_rule" "allow_my_pc" {
  name             = "AllowMyPC"
  server_id        = azurerm_mssql_server.sql_server.id
  start_ip_address = var.my_public_ip
  end_ip_address   = var.my_public_ip
}

# Database: Transaction
# resource "azurerm_mssql_database" "sql_database_transaction" {
#   name      = "sqldb-transaction-westus2"
#   server_id = azurerm_mssql_server.sql_server.id
#   sku_name  = "Basic"
# }

# Database: Balance
# resource "azurerm_mssql_database" "sql_database_balance" {
#   name      = "sqldb-balance-westus2"
#   server_id = azurerm_mssql_server.sql_server.id
#   sku_name  = "Basic"
# }

# Database: Transfer
# resource "azurerm_mssql_database" "sql_database_transfer" {
#   name      = "sqldb-transfer-westus2"
#   server_id = azurerm_mssql_server.sql_server.id
#   sku_name  = "Basic"
# }

# Cosmos DB for the Notification service

resource "azurerm_cosmosdb_account" "cosmosdb_account_notification" {
  name                = "cosmos-notification-westus2-sid"
  location            = azurerm_resource_group.rm.location
  resource_group_name = azurerm_resource_group.rm.name
  offer_type          = "Standard"

  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location          = azurerm_resource_group.rm.location
    failover_priority = 0
  }
}

resource "azurerm_cosmosdb_sql_database" "cosmos_sql_notification" {
  name                = "cosmosdb-notification"
  resource_group_name = azurerm_resource_group.rm.name
  account_name        = azurerm_cosmosdb_account.cosmosdb_account_notification.name
}
