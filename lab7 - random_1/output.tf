output "rg_name" {
    value = azurerm_resource_group.rg_name.name 
}

output "rg_location" {
    value = azurerm_resource_group.rg_name.location 
}

output "rg_id" {
    value = azurerm_resource_group.rg_name.id 
}

output "st_acc_name" {
  value = azurerm_storage_account.storage_acc_name.name
}