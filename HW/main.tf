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

resource "azurerm_virtual_network" "vnets" {
  for_each = var.vnets

  name = each.key
  address_space = [each.value.address_space]
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location

  dynamic "subnet" {
    for_each = each.value.Subnets

    content {
      name = each.value.Subnets[subnet.key].name
      address_prefix = cidrsubnet(each.value.address_space , each.value.Subnets[subnet.key].newbits , each.value.Subnets[subnet.key].netnum)
    }
  }
  depends_on = [ azurerm_resource_group.rg ]

}

resource "azurerm_network_security_group" "nsg" {   // Created Multiple Nsg
  count = var.nsg_count
  name = "nsg-${count.index+1}"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location

  security_rule {                                   //  Apply One rule for Each Nsg
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
  depends_on = [ azurerm_virtual_network.vnets ]
}

