# locals {
#   all_policy_definitions = flatten([
#     for scope_folder in keys(local.mg_mapping) : [
#       for file in try(fileset("${path.module}/policies/definitions/scope/${scope_folder}/policies", "*.jsonc"), []) : {
#         scope_folder   = scope_folder
#         filename       = file
#         policy_name    = trimsuffix(file, ".jsonc")
#         mg_id          = local.mg_mapping[scope_folder]
#         policy_content = jsondecode(file("${path.module}/policies/definitions/scope/${scope_folder}/policies/${file}"))
#       }
#     ]
#   ])
#
#   policy_definitions = {
#     for policy in local.all_policy_definitions :
#     "${policy.scope_folder}-${policy.policy_name}" => policy
#   }
# }

# resource "azapi_resource" "policy_definitions" {
#   for_each  = local.policy_definitions
#   type      = "Microsoft.Authorization/policyDefinitions@2021-06-01"
#   name      = each.value.policy_name
#   parent_id = "/providers/Microsoft.Management/managementGroups/${each.value.mg_id}"
#   body = {
#     properties = each.value.policy_content
#   }
# }

resource "azurerm_policy_definition" "example" {
  name                = "somenamezurerm"
  policy_type         = "Custom"
  mode                = "All"
  management_group_id = "/providers/Microsoft.Management/managementGroups/plbtf-sandbox-test"
  display_name        = "some display name"
  description         = "some new description"
  metadata = jsonencode({
    category = "General"
  })
  # parameters = jsonencode({
  #   allowedLocations = {
  #     type = "Array"
  #     metadata = {
  #       displayName = "Allowed locations"
  #       description = "The list of allowed locations for resources"
  #     }
  #     defaultValue = ["eastus", "westus"]
  #   }
  # })
  policy_rule = jsonencode({
    if = {
      field = "location"
      in    = ["eastus", "westus"]
    }
    then = {
      effect = "deny"
    }
  })
  # version = "1.0.0"
}
