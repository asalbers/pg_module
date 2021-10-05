variable "administrator_login" {
  description = "(Required) The Administrator Login for the PostgreSQL Server."
  default     = "pgadminacct"
}

variable "administrator_login_password" {
    description = "administrator password for the Postgres database"
    default     = "Don0ts3tth1sh3r3!"
}

variable "location" {
  description = "(Optional) Specifies the supported Azure location where the resource exists."
  default     = "eastus"
}

variable "name" {
  description = "(Required) The name of the PostgreSQL Server."
  default     = "pg-terraform-test-module"
}

variable "pgsql_version" {
  description = "(Required) The version of the PostgreSQL Server."
  default     = "11"
}

variable "resource_group" {
  description = "(Required) The name of the resource group in which to create the PostgreSQL Server."
  default     = ""
}

variable "retention_days" {
  description = "(Optional) Specifies the retention in days for logs for this PostgreSQL Server."
  default     = 35
}

variable "sku_name" {
  description = "(Required) Specifies the SKU Name for this PostgreSQL Server."
  default     = "B_Gen5_2"
}

variable "ssl_enforcement_enabled" {
  description = "(Required) Specifies if SSL should be enforced on connections."
  default     = true
}

variable "storagesize_mb" {
  description = "(Required) Specifies the version of PostgreSQL to use."
  default     = 51200
}

variable "tags" {
  type = map(string)
  default = {
    environment : "dev",
    test  : "HOL"
  }
}

