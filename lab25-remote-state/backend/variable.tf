variable "location" {
  description = "The region in which the resources will be deployed"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}


variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
}

# tfvars file :

# resource_group_name = "tfstate2024_RG"
# location = "east us"
# storage_account_name = "tflearnremotestatestacc"