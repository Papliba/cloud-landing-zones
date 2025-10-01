# Root Management Group
resource "azurerm_management_group" "root_mg" {
  name         = var.root
  display_name = var.root
}

# Landing Zones Management Group
resource "azurerm_management_group" "landingzones_mg" {
  name                       = var.landingzones
  display_name               = var.landingzones
  parent_management_group_id = azurerm_management_group.root_mg.id
}

# Corp Management Group
resource "azurerm_management_group" "corp_mg" {
  name                       = var.corp
  display_name               = var.corp
  parent_management_group_id = azurerm_management_group.landingzones_mg.id
}

# Online Management Group
resource "azurerm_management_group" "online_mg" {
  name                       = var.online
  display_name               = var.online
  parent_management_group_id = azurerm_management_group.landingzones_mg.id
}

# Decommisioned Management Group
resource "azurerm_management_group" "decommisioned_mg" {
  name                       = var.decommisioned
  display_name               = var.decommisioned
  parent_management_group_id = azurerm_management_group.root_mg.id
}

# Sandbox Management Group
resource "azurerm_management_group" "sandbox_mg" {
  name                       = var.sandbox
  display_name               = var.sandbox
  parent_management_group_id = azurerm_management_group.root_mg.id
}

# Platform Management Group
resource "azurerm_management_group" "platform_mg" {
  name                       = var.platform
  display_name               = var.platform
  parent_management_group_id = azurerm_management_group.root_mg.id
}

# Security Management Group
resource "azurerm_management_group" "security_mg" {
  name                       = var.security
  display_name               = var.security
  parent_management_group_id = azurerm_management_group.platform_mg.id
}

# Management Management Group
resource "azurerm_management_group" "management_mg" {
  name                       = var.management
  display_name               = var.management
  parent_management_group_id = azurerm_management_group.platform_mg.id
}

# Identity Management Group
resource "azurerm_management_group" "identity_mg" {
  name                       = var.identity
  display_name               = var.identity
  parent_management_group_id = azurerm_management_group.platform_mg.id
}

# Connectivity Management Group
resource "azurerm_management_group" "connectivity_mg" {
  name                       = var.connectivity
  display_name               = var.connectivity
  parent_management_group_id = azurerm_management_group.platform_mg.id
}
