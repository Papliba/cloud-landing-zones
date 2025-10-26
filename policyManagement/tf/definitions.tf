locals {
  # Get all policy definition files (both .json and .jsonc) from the policies/definitions/scope/root-mg/policies folder
  policy_files_jsonc = fileset("${path.module}/policies/definitions/scope/root-mg/policies", "*.jsonc")
  policy_files_json  = fileset("${path.module}/policies/definitions/scope/root-mg/policies", "*.json")
  policy_files       = setunion(local.policy_files_jsonc, local.policy_files_json)

  # Read and parse policy files
  # - JSONC files: strip comments using external Python script
  # - JSON files: read directly
  policy_file_contents = {
    for file in local.policy_files :
    file => endswith(file, ".jsonc")
    ? jsondecode(file("${path.module}/policies/definitions/scope/root-mg/policies/${file}"))
    : jsondecode(file("${path.module}/policies/definitions/scope/root-mg/policies/${file}"))
  }

  # Create policy definitions map with clean names as keys
  policy_definitions = {
    for file, content in local.policy_file_contents :
    replace(replace(file, ".jsonc", ""), ".json", "") => content
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
