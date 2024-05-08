resource "azurerm_resource_group" "rg" {
  name = local.rg_name
  location = local.location
}

resource "azurerm_virtual_network" "vnets" {
  for_each = local.vnets

  name = each.key
  address_space = [ each.value ]
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  depends_on = [ azurerm_resource_group.rg ]
}