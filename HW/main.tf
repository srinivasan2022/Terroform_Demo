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

resource "azurerm_network_security_group" "nsg" {      // Created Multiple Nsg
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


locals {
  vnet_ids = {
    for vnet_key, vnet_val in azurerm_virtual_network.vnets :
    vnet_key => [for subnet in vnet_val.subnet : subnet.id]
  }
  vnet_name = keys(local.vnet_ids)
  subnet_id = values(local.vnet_ids)
  subnet_ids = flatten(local.subnet_id)
}

resource "azurerm_subnet_network_security_group_association" "nsg_ass" {
 count = length(local.subnet_ids)
 subnet_id = local.subnet_ids[count.index]
 network_security_group_id = azurerm_network_security_group.nsg[count.index].id 
 depends_on = [ azurerm_network_security_group.nsg ]
}

# local.vnet_name --> ["vnet1" , "vnet2"]
# local.subnet_id --> [ [subnet1.id , subnet2.id] , [subnet1.id , subnet2.id]]
# local.subnet_ids --> [ subnet1.id , subnet2.id , subnet1.id , subnet2.id ]
# flatten([[1,2] , [3,4] , [5,6]) --> [ 1,2,3,4,5,6] 


