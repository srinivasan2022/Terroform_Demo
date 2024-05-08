# locals {
#   network = yamldecode(file("vnet.yaml"))
# }

# resource "azurerm_resource_group" "rg_name" {
#   name  =local.network.resource_group
#   location = local.network.location
# }

# resource "azurerm_virtual_network" "vnet" {
#     name = local.network.vnet
#     resource_group_name =azurerm_resource_group.rg_name.name
#     location = azurerm_resource_group.rg_name.location
#     address_space = local.network.address_space
#     dynamic "subnet" {
#       for_each = local.network.subnets
#       content {
#         name = subnet.value.name
#         address_prefix = subnet.value.iprange
#       }
#     }
  
# }


locals {
  network = yamldecode(file("vnet.yaml"))
}
 
resource "azurerm_resource_group" "rg" {
  name = local.network.resource_group
  location = local.network.location
}
 
resource "azurerm_virtual_network" "virtualnetwork" {
  name = local.network.vnet
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space = [ local.network.address_space ]
  dynamic "subnet" {
    for_each = local.network.subnets
    content {
      address_prefix = subnet.value.iprange
      name = subnet.value.name
    }
   
  }
}