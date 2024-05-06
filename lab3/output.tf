output "rg_name" {
    value = azurerm_resource_group.rg1.name     // var.az_rg_name     // value = azurerm_resource_group.customName.name     
}
                                                
output "rg_location" {
    value = azurerm_resource_group.rg1.location
}

output "rg_id" {
  value = azurerm_resource_group.rg1.id
}