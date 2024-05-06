terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"            // This is our provider file in terraform
        version = "~> 3.0.2"
    }
  }
  required_version = ">= 1.1.0"
}

provider "azurerm" {
    features {}
}