locals {
  all_policy_files = fileset("../policies/definitions/scope", "**/policies/*.json")
  policy_definitions = {
    for file_path in local.all_policy_files :
    "${dirname(dirname(file_path))}-${replace(basename(file_path), ".json", "")}" => {
      content               = jsondecode(file("${path.module}/policies/definitions/scope/${file_path}"))
      management_group_name = dirname(dirname(file_path))
      file_path             = file_path
    }
  }
}

resource "azurerm_policy_definition" "definitions" {
  for_each            = local.policy_definitions
  name                = each.value.content.name
  policy_type         = "Custom"
  mode                = each.value.content.properties.mode
  display_name        = each.value.content.properties.displayName
  description         = each.value.content.properties.description
  metadata            = jsonencode(each.value.content.properties.metadata)
  parameters          = jsonencode(each.value.content.properties.parameters)
  policy_rule         = jsonencode(each.value.content.properties.policyRule)
  management_group_id = "/providers/Microsoft.Management/managementGroups/${each.value.management_group_name}${var.environment}"
}
