locals {
  # Discover all policy definition JSON files across all management group scopes
  # Note: JSONC files are automatically converted to JSON by the pipeline before Terraform runs
  # The folder structure determines deployment scope: policies/definitions/scope/{mg-name}/policies/*.json

  # Find all policy files with their full paths
  all_policy_files = fileset("${path.module}/policies/definitions/scope", "**/policies/*.json")

  # Parse policy files and extract management group from path
  # fileset returns paths like "plbtf-sandbox-test/policies/file.json"
  # dirname(dirname(file_path)) gets the management group name
  policy_definitions = {
    for file_path in local.all_policy_files :
    "${dirname(dirname(file_path))}-${replace(basename(file_path), ".json", "")}" => {
      content             = jsondecode(file("${path.module}/policies/definitions/scope/${file_path}"))
      management_group_id = dirname(dirname(file_path))
      file_path           = file_path
    }
  }
}

resource "azurerm_policy_definition" "policies" {
  for_each     = local.policy_definitions
  name         = each.value.content.name
  policy_type  = "Custom"
  mode         = each.value.content.properties.mode
  display_name = each.value.content.properties.displayName
  description  = each.value.content.properties.description
  metadata     = jsonencode(each.value.content.properties.metadata)
  parameters   = jsonencode(each.value.content.properties.parameters)
  policy_rule  = jsonencode(each.value.content.properties.policyRule)

  # Temporarily hardcoded for testing - using full resource ID format
  management_group_id = "/providers/Microsoft.Management/managementGroups/plbtf-sandbox-test"
}
