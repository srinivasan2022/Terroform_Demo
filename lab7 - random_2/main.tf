resource "random_string" "random_for_rg" {
    length = 5
    special = false
}

resource "random_string" "random_for_stacc" {
    length = 5
    special = false
    upper = false
}

resource "azurerm_resource_group" "rg_name" {
  name="${local.rg_name}-${random_string.random_for_rg.result}"
  location = local.location
}

resource "azurerm_storage_account" "storage_acc_name" {
    name = "${local.storage_acc_name}${random_string.random_for_stacc.result}"
    resource_group_name = azurerm_resource_group.rg_name.name
    location = azurerm_resource_group.rg_name.location
    account_tier = "Standard"
    account_replication_type = "LRS"
    depends_on = [ azurerm_resource_group.rg_name ]
  
}