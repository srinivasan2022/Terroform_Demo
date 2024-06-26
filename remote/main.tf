resource "azurerm_network_interface" "example" {
  for_each = local.vnets

  name                = "${each.key}-nic"
  location            = local.vnets[each.key].location
  resource_group_name = local.vnets[each.key].resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = element([for s in each.value.subnet : s.id], 0)
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_linux_virtual_machine" "example" {
  for_each = local.vnets

  name                = "${each.key}-vm"
  location            = local.vnets[each.key].location
  resource_group_name = local.vnets[each.key].resource_group_name
  size                = "Standard_DS1_v2"

  network_interface_ids = [azurerm_network_interface.example[each.key].id]

  admin_username                  = "adminuser"
  admin_password                  = "Password1234!"
  disable_password_authentication = false

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  custom_data = filebase64("${path.module}/web-server-cloud-init.txt")
  tags        = local.common_tags
}