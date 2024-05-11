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

variable "vnet_names" {
  type    = list(string)
  default = ["vnet1", "vnet3", "vnet2"]
}

variable "address_spaces" {
  type    = list(string)
  default = ["10.0.0.0/16", "10.2.0.0/16", "10.1.0.0/16"]
}

locals {
  location       = "East US"
  resource_group = "vnet-example-rg"
  vnets          = zipmap(var.vnet_names, var.address_spaces)
}

resource "azurerm_resource_group" "example" {
  name     = local.resource_group
  location = local.location
}

resource "azurerm_virtual_network" "vnets" {
  for_each = local.vnets

  name                = each.key
  address_space       = [each.value]
  location            = local.location
  resource_group_name = azurerm_resource_group.example.name
}

output "my_map_output" {
  value = local.vnets
}

# When we use for_each :

# The for_each performed by (key , value) pair

# Example : vnet1 -> "10.0.0.0/16" , vnet2 -> "10.1.0.0/16" , vnet3 -> "10.2.0.0/16"

# After changed :  vnet1 -> "10.0.0.0/16" , vnet3 -> "10.2.0.0/16" , vnet2 -> "10.1.0.0/16" 

# The for-each can check the Vnets and says "No changes"