data "terraform_remote_state" "network" {
  backend = "azurerm"
  config = {
    resource_group_name  = "tfstate2024_RG"
    storage_account_name = "tflearnremotestatestacc"
    container_name       = "network-terraform-state"
    key                  = "terraform.tfstate"
  }
}