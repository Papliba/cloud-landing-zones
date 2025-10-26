locals {
  # Get all policy definition files from the policies/definitions folder
  policy_files = fileset("${path.module}/policies/definitions", "*.jsonc")

  # Parse each policy definition file
  policy_definitions = {
    for file in local.policy_files :
    trimsuffix(file, ".jsonc") => jsondecode(file("${path.module}/policies/definitions/${file}"))
  }
}

resource "azurerm_policy_definition" "policies" {
  for_each = local.policy_definitions

  name                = each.value.name
  policy_type         = "Custom"
  mode                = each.value.properties.mode
  management_group_id = "/providers/Microsoft.Management/managementGroups/plbtf-sandbox-test"
  display_name        = each.value.properties.displayName
  description         = each.value.properties.description

  metadata = jsonencode(each.value.properties.metadata)

  parameters = jsonencode(each.value.properties.parameters)

  policy_rule = jsonencode(each.value.properties.policyRule)
}
