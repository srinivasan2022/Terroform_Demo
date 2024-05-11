terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "~> 3.0.2"
    }
  }
  required_version = ">= 1.1.0"           // Create a Resource Group using Terraform
}

provider "azurerm" {
    features {}
  
}

resource "azurerm_resource_group" "rg" {
    name = "myrg"
    location = "southeast asia"  
}

resource "azurerm_resource_group" "rg1" {
    name = "myrg1"
    location = "southeast asia"  
}