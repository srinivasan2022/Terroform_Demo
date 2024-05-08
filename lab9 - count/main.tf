resource "random_string" "rdm" {
    length = 4
    special = false
}

resource "azurerm_resource_group" "rg_name" {
  name = local.rg_name
  location = local.location
}

resource "azurerm_virtual_network" "vnet" {
  count = local.vnet_count
  name = "${local.vnet_name}-${random_string.rdm.result}-${count.index + 1}"
  resource_group_name = azurerm_resource_group.rg_name.name
  location = azurerm_resource_group.rg_name.location
  address_space = ["10.0.0.0/16"]
}