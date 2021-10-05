# pg_module

## Setup

These setup instructions are there if you want to run the lab in your own subscription.

Required software

```sh
terraform
azure cli
Text editor (vscode ideal, but not required)
```

[Installing Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/azure-get-started#install-terraform)

[Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)

[Visual Studio Code](https://code.visualstudio.com/Download)

Suggested vscode extensions:
Azure Terraform
HashiCorp Terraform

## Azure authentication

Make sure you ran "az login" and followed the prompts or have a service principal specified with the variables exported in your shell.

```sh
az login
az account set -s <sub id>
```

## Examing the terraform files

Clone the files to your local machine or copy them from the github repo

```sh
git clone https://github.com/asalbers/pg_module.git
```
### main.tf

Similar from the first one there is a terraform block that sets version number for the azure provider and a provider block setting the provider we are using.

The main section here to look at is the module block. This block abstracts away from the normal terraform code and allows reuse of terraform code written by others.

Items you can modify are just the databases being deployed, geo redundancy, database charset, and database collation.

### variables.tf
Values to modify are going to be similar from the other lab.

For editing tags you can modify the block in the file and add your tags in the map below.
```sh
variable "tags" {
  type = map(string)
  default = {
    environment : "dev",
    test  : "HOL"
  }
}
```

You can also edit the resource group in variables.tf file in the block specified below.
```sh
variable "resource_group" {
  description = "(Required) The name of the resource group in which to create the PostgreSQL Server."
  default     = "AALabRG"
}
```

Two other values to modify are the administrator_login and the administrator_login_password. Its not required to modify these, but if you unique admin password and login information it would be good to change these to different values.
```sh
variable "administrator_login" {
  description = "(Required) The Administrator Login for the PostgreSQL Server."
  default     = "pgadminacct"
}

variable "administrator_login_password" {
    description = "administrator password for the Postgres database"
    default     = "Don0ts3tth1sh3r3!"
}
```

The last value you will want to edit is the server name itself. You can either add to the name in the variable or use your own.
```sh
variable "name" {
  description = "(Required) The name of the PostgreSQL Server."
  default     = "pg-terraform-test"
}
```

## Running the terraform module

Run terraform init to see everything it installs. In this one you will see it installing modules at the top.

```sh
terraform12 init
Initializing modules...

Initializing the backend...

Initializing provider plugins...
- Checking for available provider plugins...
- Downloading plugin for provider "azurerm" (hashicorp/azurerm) 2.79.1...


Warning: Provider source not supported in Terraform v0.12

  on main.tf line 3, in terraform:
   3:     azurerm = {
   4:       source = "hashicorp/azurerm"
   5:       version = "~>2.0"
   6:     }

A source was declared for provider azurerm. Terraform v0.12 does not support
the provider source attribute. It will be ignored.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

Things to notice in the terraform plan section are the additional resource block which you did not have to manually set.

```sh
terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.postgresql.azurerm_postgresql_database.dbs[0] will be created
  + resource "azurerm_postgresql_database" "dbs" {
      + charset             = "UTF8"
      + collation           = "English_United States.1252"
      + id                  = (known after apply)
      + name                = "my_db1"
      + resource_group_name = ""
      + server_name         = "pg-terraform-test"
    }

  # module.postgresql.azurerm_postgresql_database.dbs[1] will be created
  + resource "azurerm_postgresql_database" "dbs" {
      + charset             = "UTF8"
      + collation           = "English_United States.1252"
      + id                  = (known after apply)
      + name                = "my_db2"
      + resource_group_name = ""
      + server_name         = "pg-terraform-test"
    }

  # module.postgresql.azurerm_postgresql_server.server will be created
  + resource "azurerm_postgresql_server" "server" {
      + administrator_login              = "pgadminacct"
      + administrator_login_password     = (sensitive value)
      + auto_grow_enabled                = (known after apply)
      + backup_retention_days            = 7
      + create_mode                      = "Default"
      + fqdn                             = (known after apply)
      + geo_redundant_backup_enabled     = false
      + id                               = (known after apply)
      + location                         = "eastus"
      + name                             = "pg-terraform-test"
      + public_network_access_enabled    = true
      + resource_group_name              = ""
      + sku_name                         = "B_Gen5_2"
      + ssl_enforcement                  = (known after apply)
      + ssl_enforcement_enabled          = true
      + ssl_minimal_tls_version_enforced = "TLSEnforcementDisabled"
      + storage_mb                       = 5120
      + tags                             = {
          + "environment" = "dev"
          + "test"        = "HOL"
        }
      + version                          = "11"

      + storage_profile {
          + auto_grow             = (known after apply)
          + backup_retention_days = (known after apply)
          + geo_redundant_backup  = (known after apply)
          + storage_mb            = (known after apply)
        }
    }

Plan: 3 to add, 0 to change, 0 to destroy.

────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
```

The last output here is the terraform apply where you can see it outputting the similar items to the terraform plan and building out the infrastructure and creating the databases on postgres.

Sample output

```sh
terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.postgresql.azurerm_postgresql_database.dbs[0] will be created
  + resource "azurerm_postgresql_database" "dbs" {
      + charset             = "UTF8"
      + collation           = "English_United States.1252"
      + id                  = (known after apply)
      + name                = "my_db1"
      + resource_group_name = ""
      + server_name         = "pg-terraform-test"
    }

  # module.postgresql.azurerm_postgresql_database.dbs[1] will be created
  + resource "azurerm_postgresql_database" "dbs" {
      + charset             = "UTF8"
      + collation           = "English_United States.1252"
      + id                  = (known after apply)
      + name                = "my_db2"
      + resource_group_name = ""
      + server_name         = "pg-terraform-test"
    }

  # module.postgresql.azurerm_postgresql_server.server will be created
  + resource "azurerm_postgresql_server" "server" {
      + administrator_login              = "pgadminacct"
      + administrator_login_password     = (sensitive value)
      + auto_grow_enabled                = (known after apply)
      + backup_retention_days            = 7
      + create_mode                      = "Default"
      + fqdn                             = (known after apply)
      + geo_redundant_backup_enabled     = false
      + id                               = (known after apply)
      + location                         = "eastus"
      + name                             = "pg-terraform-test"
      + public_network_access_enabled    = true
      + resource_group_name              = ""
      + sku_name                         = "B_Gen5_2"
      + ssl_enforcement                  = (known after apply)
      + ssl_enforcement_enabled          = true
      + ssl_minimal_tls_version_enforced = "TLSEnforcementDisabled"
      + storage_mb                       = 5120
      + tags                             = {
          + "environment" = "dev"
          + "test"        = "HOL"
        }
      + version                          = "11"

      + storage_profile {
          + auto_grow             = (known after apply)
          + backup_retention_days = (known after apply)
          + geo_redundant_backup  = (known after apply)
          + storage_mb            = (known after apply)
        }
    }

Plan: 3 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

module.postgresql.azurerm_postgresql_server.server: Creating...
module.postgresql.azurerm_postgresql_server.server: Still creating... [10s elapsed]
module.postgresql.azurerm_postgresql_server.server: Still creating... [20s elapsed]
module.postgresql.azurerm_postgresql_server.server: Still creating... [30s elapsed]
module.postgresql.azurerm_postgresql_server.server: Still creating... [40s elapsed]
module.postgresql.azurerm_postgresql_server.server: Still creating... [50s elapsed]
module.postgresql.azurerm_postgresql_server.server: Still creating... [1m0s elapsed]
module.postgresql.azurerm_postgresql_server.server: Still creating... [1m10s elapsed]
module.postgresql.azurerm_postgresql_server.server: Still creating... [1m20s elapsed]
module.postgresql.azurerm_postgresql_server.server: Still creating... [1m30s elapsed]
module.postgresql.azurerm_postgresql_server.server: Still creating... [1m40s elapsed]
module.postgresql.azurerm_postgresql_server.server: Still creating... [1m50s elapsed]
module.postgresql.azurerm_postgresql_server.server: Still creating... [2m0s elapsed]
module.postgresql.azurerm_postgresql_server.server: Still creating... [2m10s elapsed]
module.postgresql.azurerm_postgresql_server.server: Still creating... [2m20s elapsed]
module.postgresql.azurerm_postgresql_server.server: Still creating... [2m30s elapsed]
module.postgresql.azurerm_postgresql_server.server: Still creating... [2m40s elapsed]
module.postgresql.azurerm_postgresql_server.server: Still creating... [2m50s elapsed]
module.postgresql.azurerm_postgresql_server.server: Still creating... [3m0s elapsed]
module.postgresql.azurerm_postgresql_server.server: Creation complete after 3m3s [id=]
module.postgresql.azurerm_postgresql_database.dbs[0]: Creating...
module.postgresql.azurerm_postgresql_database.dbs[1]: Creating...
module.postgresql.azurerm_postgresql_database.dbs[1]: Still creating... [10s elapsed]
module.postgresql.azurerm_postgresql_database.dbs[0]: Still creating... [10s elapsed]
module.postgresql.azurerm_postgresql_database.dbs[0]: Still creating... [20s elapsed]
module.postgresql.azurerm_postgresql_database.dbs[1]: Still creating... [20s elapsed]
module.postgresql.azurerm_postgresql_database.dbs[1]: Still creating... [30s elapsed]
module.postgresql.azurerm_postgresql_database.dbs[0]: Still creating... [30s elapsed]
module.postgresql.azurerm_postgresql_database.dbs[0]: Still creating... [40s elapsed]
module.postgresql.azurerm_postgresql_database.dbs[1]: Still creating... [40s elapsed]
module.postgresql.azurerm_postgresql_database.dbs[0]: Creation complete after 46s [id=]
module.postgresql.azurerm_postgresql_database.dbs[1]: Still creating... [50s elapsed]
module.postgresql.azurerm_postgresql_database.dbs[1]: Still creating... [1m0s elapsed]
module.postgresql.azurerm_postgresql_database.dbs[1]: Still creating... [1m10s elapsed]
module.postgresql.azurerm_postgresql_database.dbs[1]: Still creating... [1m20s elapsed]
module.postgresql.azurerm_postgresql_database.dbs[1]: Still creating... [1m30s elapsed]
module.postgresql.azurerm_postgresql_database.dbs[1]: Creation complete after 1m33s [id=]
```

