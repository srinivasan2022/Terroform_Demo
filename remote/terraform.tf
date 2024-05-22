terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }
  required_version = ">= 1.1.0"

  # Terraform State Storage to Azure Storage and Container (this must be part tf provider block)
  backend "azurerm" {
     resource_group_name  = "tfstate2024_RG"
     storage_account_name = "tflearnremotestatestacc"
     container_name       = "vm-terraform-state"
     key                 = "vm-terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}