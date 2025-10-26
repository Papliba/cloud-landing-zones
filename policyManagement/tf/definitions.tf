locals {
  # Get all policy definition files (both .json and .jsonc) from the policies/definitions/scope/root-mg/policies folder
  policy_files_jsonc = fileset("${path.module}/policies/definitions/scope/root-mg/policies", "*.jsonc")
  policy_files_json  = fileset("${path.module}/policies/definitions/scope/root-mg/policies", "*.json")
  policy_files       = setunion(local.policy_files_jsonc, local.policy_files_json)

  # Parse each policy definition file
  policy_definitions = {
    for file in local.policy_files :
    replace(file, "/\\.(jsonc|json)$/", "") => jsondecode(file("${path.module}/policies/definitions/scope/root-mg/policies/${file}"))
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
