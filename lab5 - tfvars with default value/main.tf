resource "azurerm_resource_group" "rg_name" {
  name=var.rg_name
  location = var.location
}

resource "azurerm_storage_account" "storage_acc_name" {
    name = var.storage_acc_name
    resource_group_name = azurerm_resource_group.rg_name.name
    location = azurerm_resource_group.rg_name.location
    account_tier = "Standard"
    account_replication_type = "LRS"
    depends_on = [ azurerm_resource_group.rg_name ]
  
}