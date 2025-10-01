# resource "azapi_resource" "mg" {
#   type      = "Microsoft.Management/managementGroups@2023-04-01"
#   name      = "papliba-tf-tet"
#   parent_id = "/providers/Microsoft.Management/managementGroups/papliba-bicep"
#   body = {
#     properties = {
#       displayName = "papliba-tf-test"
#     }
#   }
# }

resource "azapi_resource" "mg" {
  type      = "Microsoft.Management/managementGroups@2023-04-01"
  name      = "papliba-tf"
  parent_id = "/" # This is scope: tenant() in bicep
  body = {
    properties = {
      # details = {
      #   parent = {
      #     id = "string"
      #   }
      # }
      displayName = "papliba-tf"
    }
  }
}

# Root Management Group
# resource "azurerm_management_group" "mg" {
#   name         = "papliba-tf"
#   display_name = "papliba tf"
# }


# # Outputs
# output "root_mg_name" {
#   description = "The name of the root management group."
#   value       = azurerm_management_group.root.name
# }
#
# output "root_mg_id" {
#   description = "The resource ID of the root management group."
#   value       = azurerm_management_group.root.id
# }
