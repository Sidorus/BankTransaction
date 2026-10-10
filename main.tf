terraform {
  required_version = ">= 1.2"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm",
      version = "~> 4.2"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

resource "azurerm_resource_group" "rm" {
  name     = "rg-transfer-westus2"
  location = "westus2"
}

# Shared App Service Plan for all microservices

resource "azurerm_service_plan" "plan" {
  name                = "plan-banktransaction-westus2"
  location            = "westus2"
  resource_group_name = azurerm_resource_group.rm.name
  os_type             = "Linux"
  sku_name            = "F1"
}

#MS API Gateway

resource "azurerm_linux_web_app" "appservice-apigateway" {
  name                = "appserv-apigateway-westus2-sid"
  location            = "westus2"
  resource_group_name = azurerm_resource_group.rm.name
  service_plan_id     = azurerm_service_plan.plan.id
  site_config {
    always_on = false
    application_stack {
      docker_image_name = "nginx:latest"
    }
  }
}

#MS API Transaction

resource "azurerm_linux_web_app" "appservice-transaction" {
  name                = "appserv-transaction-westus2-sid"
  location            = "westus2"
  resource_group_name = azurerm_resource_group.rm.name
  service_plan_id     = azurerm_service_plan.plan.id
  site_config {
    always_on = false
    application_stack {
      docker_image_name = "nginx:latest"
    }
  }
}

#MS API Balance

resource "azurerm_linux_web_app" "appservice-balance" {
  name                = "appserv-balance-westus2-sid"
  location            = "westus2"
  resource_group_name = azurerm_resource_group.rm.name
  service_plan_id     = azurerm_service_plan.plan.id
  site_config {
    always_on = false
    application_stack {
      docker_image_name = "nginx:latest"
    }
  }
}

#MS API Transfer

resource "azurerm_linux_web_app" "appservice-transfer" {
  name                = "appserv-transfer-westus2-sid"
  location            = "westus2"
  resource_group_name = azurerm_resource_group.rm.name
  service_plan_id     = azurerm_service_plan.plan.id
  site_config {
    always_on = false
    application_stack {
      docker_image_name = "nginx:latest"
    }
  }
}

#MS API Notification

resource "azurerm_linux_web_app" "appservice-notification" {
  name                = "appserv-notification-westus2-sid"
  location            = "westus2"
  resource_group_name = azurerm_resource_group.rm.name
  service_plan_id     = azurerm_service_plan.plan.id
  site_config {
    always_on = false
    application_stack {
      docker_image_name = "nginx:latest"
    }
  }
}

# SQL Server (shared) with one database per service

variable "sql_admin_password" {
  type      = string
  sensitive = true
}

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

variable "my_public_ip" {
  type        = string
  description = "Public IP of the local PC allowed to connect to SQL"
}

# Allows the local PC to reach the server
resource "azurerm_mssql_firewall_rule" "allow_my_pc" {
  name             = "AllowMyPC"
  server_id        = azurerm_mssql_server.sql_server.id
  start_ip_address = var.my_public_ip
  end_ip_address   = var.my_public_ip
}

#DB Transaction

resource "azurerm_mssql_database" "sql_database_transaction" {
  name      = "sqldb-transaction-westus2"
  server_id = azurerm_mssql_server.sql_server.id
  sku_name  = "Basic"
}

#DB Balance

resource "azurerm_mssql_database" "sql_database_balance" {
  name      = "sqldb-balance-westus2"
  server_id = azurerm_mssql_server.sql_server.id
  sku_name  = "Basic"
}

#DB Transfer

resource "azurerm_mssql_database" "sql_database_transfer" {
  name      = "sqldb-transfer-westus2"
  server_id = azurerm_mssql_server.sql_server.id
  sku_name  = "Basic"
}
