terraform {
  required_providers {
    azapi = {
      source  = "Azure/azapi"
      version = "~>2.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstatefilesstatefiles"
    container_name       = "tfstatefiles"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  tenant_id       = "edcdcd05-f72e-4577-a6b4-5c1c367b4deb"
  subscription_id = "105027cd-ce6d-4742-9a67-ba787d5e37b8"
}

provider "azapi" {
  tenant_id       = "edcdcd05-f72e-4577-a6b4-5c1c367b4deb"
  subscription_id = "105027cd-ce6d-4742-9a67-ba787d5e37b8"
}
