terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "~> 3.0.2"
    }
  }
  required_version = ">= 1.1.0"          // Create a Resource Group with variable name
}

provider "azurerm" {
  features {}  

}

resource "azurerm_resource_group" "rg1" {
    name=var.az_rg_name
    location =var.az_rg_location
}

