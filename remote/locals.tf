locals {
  vnets       = data.terraform_remote_state.network.outputs.vnets
  rg_details  = data.terraform_remote_state.network.outputs.rg_details
  vm_name     = "tf-test-vm"
  evnironment = "development"
  project     = "terraform-azure-learning-path"
  common_tags = {
    environment = local.evnironment
    private     = local.project
  }
  name     = "seenu_RG"
  location = "southeast asia"
}

output "vnet_names" {
  value = local.vnets
}

output "rg_details" {
  value = local.rg_details

}