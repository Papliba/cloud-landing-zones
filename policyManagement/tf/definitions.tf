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

resource "azurerm_policy_definition" "enforce_naming_convention" {
  name                = "enforce-naming-convention"
  policy_type         = "Custom"
  mode                = "All"
  management_group_id = "/providers/Microsoft.Management/managementGroups/plbtf-sandbox-test"
  display_name        = "Enforce Subscription Naming Convention"
  description         = "This policy enforces naming conventions for Azure subscriptions to ensure consistency across the organization."

  metadata = jsonencode({
    category = "Naming Convention"
    version  = "1.0.0"
  })

  parameters = jsonencode({
    effect = {
      type = "String"
      metadata = {
        displayName = "Effect"
        description = "Enable or disable the execution of the policy"
      }
      allowedValues = ["Deny", "Audit", "Disabled"]
      defaultValue  = "Audit"
    }
    namePattern = {
      type = "String"
      metadata = {
        displayName = "Name Pattern"
        description = "The regex pattern that subscription names must match. Format: plbtf-<applicationname>-sc-<environment>-<sequencenumber>"
      }
      defaultValue = "^plbtf-[a-z0-9]+-sc-(dev|test|nonprod|prod)-[0-9]{3}$"
    }
  })

  policy_rule = jsonencode({
    if = {
      allOf = [
        {
          field  = "type"
          equals = "Microsoft.Resources/subscriptions"
        },
        {
          not = {
            field = "name"
            match = "[parameters('namePattern')]"
          }
        }
      ]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
}
