resource "azurerm_resource_group" "rg1" {        // "rg1" --> custom Name
    name=var.az_rg_name                          // Output :  value = azurerm_resource_group.customName.name
    location =var.az_rg_location
  
}