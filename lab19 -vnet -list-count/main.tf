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
  default = ["vnet1", "vnet2", "vnet3"]
}

variable "vnet_address_spaces" {
  type    = list(string)
  default = ["10.0.0.0/16", "10.1.0.0/16", "10.2.0.0/16"]
}

variable "location" {
  type    = string
  default = "East US"
}

resource "azurerm_resource_group" "example" {
  name     = "vent-example-rg"
  location = var.location
}

resource "azurerm_virtual_network" "vnets" {
  count               = length(var.vnet_names)
  name                = var.vnet_names[count.index]
  address_space       = [var.vnet_address_spaces[count.index]]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

# When we use count func :

# The count func performed by index value (0,1,2..)

# Example : vnet1 -> "10.0.0.0/16" , vnet2 -> "10.1.0.0/16" , vnet3 -> "10.2.0.0/16"

# After changed :  vnet1 -> "10.0.0.0/16" , vnet3 -> "10.2.0.0/16" , vnet2 -> "10.1.0.0/16" 

# The count func destroy these 3 Vnets and again Recreate these 3 Vnets  

