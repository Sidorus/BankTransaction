# Resource group that holds every resource of the BankTransaction system.
# The other resources are split by area:
#   monitoring.tf  Log Analytics, Application Insights
#   security.tf    Key Vault
#   messaging.tf   Service Bus
#   databases.tf   SQL server and databases, Cosmos DB
#   apps.tf        App Service plan and the microservice web apps
#   functions.tf   Dead-letter function and its storage

resource "azurerm_resource_group" "rm" {
  name     = "rg-transfer-westus2"
  location = var.location
}
