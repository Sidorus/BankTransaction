# App Service plan shared by all microservices

resource "azurerm_service_plan" "plan" {
  name                = "plan-banktransaction-westus2"
  location            = azurerm_resource_group.rm.location
  resource_group_name = azurerm_resource_group.rm.name
  os_type             = "Linux"
  sku_name            = "F1"
}

# Microservice: API Gateway

resource "azurerm_linux_web_app" "appservice-apigateway" {
  name                = "appserv-apigateway-westus2-sid"
  location            = azurerm_resource_group.rm.location
  resource_group_name = azurerm_resource_group.rm.name
  service_plan_id     = azurerm_service_plan.plan.id

  site_config {
    always_on = false
    application_stack {
      docker_image_name = "nginx:latest"
    }
  }

  app_settings = {
    APPLICATIONINSIGHTS_CONNECTION_STRING = azurerm_application_insights.appinsights.connection_string
  }
}

# Microservice: Transaction

resource "azurerm_linux_web_app" "appservice-transaction" {
  name                = "appserv-transaction-westus2-sid"
  location            = azurerm_resource_group.rm.location
  resource_group_name = azurerm_resource_group.rm.name
  service_plan_id     = azurerm_service_plan.plan.id

  site_config {
    always_on = false
    application_stack {
      docker_image_name = "nginx:latest"
    }
  }

  app_settings = {
    APPLICATIONINSIGHTS_CONNECTION_STRING = azurerm_application_insights.appinsights.connection_string
  }
}

# Microservice: Balance

resource "azurerm_linux_web_app" "appservice-balance" {
  name                = "appserv-balance-westus2-sid"
  location            = azurerm_resource_group.rm.location
  resource_group_name = azurerm_resource_group.rm.name
  service_plan_id     = azurerm_service_plan.plan.id

  site_config {
    always_on = false
    application_stack {
      docker_image_name = "nginx:latest"
    }
  }

  app_settings = {
    APPLICATIONINSIGHTS_CONNECTION_STRING = azurerm_application_insights.appinsights.connection_string
  }
}

# Microservice: Transfer

resource "azurerm_linux_web_app" "appservice-transfer" {
  name                = "appserv-transfer-westus2-sid"
  location            = azurerm_resource_group.rm.location
  resource_group_name = azurerm_resource_group.rm.name
  service_plan_id     = azurerm_service_plan.plan.id

  site_config {
    always_on = false
    application_stack {
      docker_image_name = "nginx:latest"
    }
  }

  app_settings = {
    APPLICATIONINSIGHTS_CONNECTION_STRING = azurerm_application_insights.appinsights.connection_string
  }
}

# Microservice: Notification

resource "azurerm_linux_web_app" "appservice-notification" {
  name                = "appserv-notification-westus2-sid"
  location            = azurerm_resource_group.rm.location
  resource_group_name = azurerm_resource_group.rm.name
  service_plan_id     = azurerm_service_plan.plan.id

  site_config {
    always_on = false
    application_stack {
      docker_image_name = "nginx:latest"
    }
  }

  app_settings = {
    APPLICATIONINSIGHTS_CONNECTION_STRING = azurerm_application_insights.appinsights.connection_string
  }
}
