terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "postgresql" {
    source = "Azure/postgresql/azurerm"
    resource_group_name = var.resource_group
    location            = var.location

    server_name                  = var.name
    sku_name                     = var.sku_name
    storage_mb                   = var.storagesize_mb
    backup_retention_days        = var.retention_days
    geo_redundant_backup_enabled = false
    administrator_login          = var.administrator_login
    administrator_password       = var.administrator_login_password
    server_version               = var.pgsql_version
    ssl_enforcement_enabled      = var.ssl_enforcement_enabled
    db_names                     = ["my_db1", "my_db2"]
    db_charset                   = "UTF8"
    db_collation                 = "English_United States.1252"

    tags = var.tags

}