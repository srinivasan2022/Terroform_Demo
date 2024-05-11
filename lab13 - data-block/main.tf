// Create the Resources in Existing Resource Rroup

terraform {
  required_providers {
    azurerm = {
       source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }
  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "ex_rg" {
  name = "demo_rg"
}

resource "azurerm_storage_account" "st_acc" {
  name = local.st_acc_name
  location = local.location
  resource_group_name = data.azurerm_resource_group.ex_rg.name
  account_tier = "Standard"
  account_replication_type = "LRS"
}