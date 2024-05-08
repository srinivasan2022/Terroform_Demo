variable "rg_name" {
  type = string
  default = "myrg1"
}

variable "location" {
  type = string
  default = "southeast asia"
}

variable "vnet_names" {
  type = list(string)
  default = [ "vnet1" , "vnet2" , "vnet3" ]
}

variable "vnet_address_prefixes" {
  type = list(string)
  default = [ "10.0.0.0/16" , "10.1.0.0/16" , "10.2.0.0/16"]
}