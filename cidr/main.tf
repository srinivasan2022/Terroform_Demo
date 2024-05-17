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
  name = "vnet"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  address_space = ["10.0.0.0/16"]
  depends_on = [ azurerm_resource_group.rg ]
}

resource "azurerm_subnet" "subnet" {
  name = "subnet"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name = azurerm_resource_group.rg.name
  address_prefixes = [cidrsubnet(azurerm_virtual_network.vnet.address_space[0], 8, 10)]    //"10.0.10.0/24"
 depends_on = [ azurerm_virtual_network.vnet ]
}

# cidrsubnet(prefix , newbits , netnum)
# prefix --> vnet_address_space
# newbits --> /24 or /32... Calculate (10.0.0.0/16 , 8 , 10) --> 16+8 = 24
# netnum --> subnet_no ... (10.0.0.0/16 , 8 , 10) --> 10.0.10.0/24