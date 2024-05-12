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

resource "azurerm_virtual_network" "vnet" {
  name = "myvnet"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  address_space = [ "10.1.0.0/16" ]
  depends_on = [ azurerm_resource_group.rg ]
}

resource "azurerm_subnet" "subnet1" {
  name = "subnet1"
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes = [ "10.1.1.0" ]
  depends_on = [ azurerm_virtual_network.vnet ]
}

resource "azurerm_network_security_group" "nsg" {      // Create the NSG for Subnet
  name = "subnet1-nsg"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
}

resource "azurerm_network_security_rule" "nsg_rule" {     // Create the NSG Rule for NSG
      name                       = "rule"
      priority                   = 100
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      network_security_group_name = azurerm_network_security_group.nsg.name
      resource_group_name = azurerm_resource_group.rg.name
      
}


