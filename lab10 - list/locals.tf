locals {
  rg_name = "Seenu_RG_123"
  location = "central india"
  vnet_names = ["vnet1" , "vnet2" , "vnet3"]
  vnet_address_prefixes = [ "10.20.0.0/16" , "10.21.0.0/16" , "10.22.0.0/16"]
  vnets = zipmap(var.vnet_names , var.vnet_address_prefixes)
}