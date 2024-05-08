resource "azurerm_resource_group" "rg_name" {
    for_each = var.vnets
    name = each.value.resource_group
    location = each.value.location
}

resource "azurerm_virtual_network" "vnets" {
    for_each = var.vnets
    
   name = each.key
   address_space = [each.value.address_prefix]
   resource_group_name = each.value.resource_group
   location = each.value.location
   depends_on = [ azurerm_resource_group.rg_name ]
}