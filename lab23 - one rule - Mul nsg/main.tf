// Apply one Rule for Multiple NSG

terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "~> 3.0.2"
    }
  }
  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name = "demo_rg"
  location = "central india"
}

locals {
  nsg_names ={
      "nsg-vnet1-subnet1" = {
      name = "nsg-vnet1-subnet1"
    },
    "nsg-vnet1-subnet2" = {
      name = "nsg-vnet1-subnet2"
    },
    "nsg-vnet1-subnet3" = {
      name = "nsg-vnet1-subnet3"
    }
  }
}

resource "azurerm_network_security_group" "nsg" {
   for_each =  local.nsg_names
   name = each.value.name
   resource_group_name = azurerm_resource_group.rg.name
   location = azurerm_resource_group.rg.location

   security_rule  {

      name                       = "Allowed"
      priority                   = 100
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
   }
}
