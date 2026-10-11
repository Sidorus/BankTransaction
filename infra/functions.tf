# Dead-letter function (Flex Consumption) and the storage it needs

# Storage account required by the Functions runtime
resource "azurerm_storage_account" "storage_account_function" {
  name                     = "stackfuncwest2"
  resource_group_name      = azurerm_resource_group.rm.name
  location                 = azurerm_resource_group.rm.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Blob container where Flex Consumption keeps the function's deployment package
resource "azurerm_storage_container" "function_deployment" {
  name                  = "deploymentpackage"
  storage_account_id    = azurerm_storage_account.storage_account_function.id
  container_access_type = "private"
}

resource "azurerm_service_plan" "plan_deadletter" {
  name                = "plan-deadletter-westus2"
  location            = azurerm_resource_group.rm.location
  resource_group_name = azurerm_resource_group.rm.name
  os_type             = "Linux"
  sku_name            = "FC1"
}

resource "azurerm_function_app_flex_consumption" "function_deadletter" {
  name                = "func-deadletter-westus2-sid"
  location            = azurerm_resource_group.rm.location
  resource_group_name = azurerm_resource_group.rm.name
  service_plan_id     = azurerm_service_plan.plan_deadletter.id

  storage_container_type      = "blobContainer"
  storage_container_endpoint  = "${azurerm_storage_account.storage_account_function.primary_blob_endpoint}${azurerm_storage_container.function_deployment.name}"
  storage_authentication_type = "SystemAssignedIdentity"

  runtime_name           = "dotnet-isolated"
  runtime_version        = "8.0"
  maximum_instance_count = 40
  instance_memory_in_mb  = 2048

  identity {
    type = "SystemAssigned"
  }

  site_config {
    application_insights_connection_string = azurerm_application_insights.appinsights.connection_string
  }
}

# Lets the function read and write its storage with its managed identity (no access key)
resource "azurerm_role_assignment" "function_deadletter_storage" {
  scope                = azurerm_storage_account.storage_account_function.id
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = azurerm_function_app_flex_consumption.function_deadletter.identity[0].principal_id
}
