locals {
  all_assignment_files = fileset("${path.module}/policies/assignments/socpe", "**/*.json")
  assignment_definitions = {
    for file_path in local.all_assignment_files :
    "${dirname(file_path)}-${replace(basename(file_path), ".json", "")}" => {
      content               = jsondecode(file("${path.module}/policies/assignments/socpe/${file_path}"))
      management_group_name = dirname(file_path)
      file_path             = file_path
    }
  }
}

resource "azurerm_management_group_policy_assignment" "assignments" {
  for_each             = local.assignment_definitions
  name                 = each.value.content.name
  display_name         = each.value.content.properties.displayName
  description          = each.value.content.properties.description
  management_group_id  = "/providers/Microsoft.Management/managementGroups/${each.value.management_group_name}"
  policy_definition_id = each.value.content.properties.policyDefinitionId
  metadata             = jsonencode(each.value.content.properties.metadata)
  parameters           = jsonencode(each.value.content.properties.parameters)
  enforce              = each.value.content.properties.enforcementMode == "Default" ? true : false

  dynamic "non_compliance_message" {
    for_each = try(each.value.content.properties.nonComplianceMessages, [])
    content {
      content = non_compliance_message.value.message
    }
  }

  depends_on = [
    azurerm_policy_definition.definitions,
    azurerm_management_group_policy_set_definition.initiatives
  ]
}
