provider "azurerm" {
  features {}
  subscription_id = "e4403c08-7702-43b0-82c7-32b902aa0933"
}

data "azurerm_subscription" "current" {}

resource "azurerm_management_group" "papliba-root" {
       display_name = "papliba"
}

resource "azurerm_management_group" "core" {
       display_name               = "core-platform"
       parent_management_group_id = azurerm_management_group.papliba-root.id
       subscription_ids           = [
          data.azurerm_subscription.current.subscription_id,
       ]
}

resource "azurerm_management_group" "applications" {
       display_name               = "applications"
       parent_management_group_id = azurerm_management_group.papliba-root.id
}

resource "azurerm_management_group" "share" {
       display_name               = "shared"
       parent_management_group_id = azurerm_management_group.papliba-root.id
}
