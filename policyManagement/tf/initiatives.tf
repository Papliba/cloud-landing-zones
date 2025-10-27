locals {
  all_initiative_files = fileset("${path.module}/policies/definitions/scope", "**/initiatives/*.json")
  initiative_definitions = {
    for file_path in local.all_initiative_files :
    "${dirname(dirname(file_path))}-${replace(basename(file_path), ".json", "")}" => {
      content               = jsondecode(file("${path.module}/policies/definitions/scope/${file_path}"))
      management_group_name = dirname(dirname(file_path))
      file_path             = file_path
    }
  }
}

resource "azurerm_management_group_policy_set_definition" "initiatives" {
  for_each            = local.initiative_definitions
  name                = each.value.content.name
  policy_type         = "Custom"
  display_name        = each.value.content.properties.displayName
  description         = each.value.content.properties.description
  metadata            = jsonencode(each.value.content.properties.metadata)
  parameters          = jsonencode(each.value.content.properties.parameters)
  management_group_id = "/providers/Microsoft.Management/managementGroups/${each.value.management_group_name}${var.environment}"
  dynamic "policy_definition_reference" {
    for_each = each.value.content.properties.policyDefinitions
    content {
      policy_definition_id = replace(policy_definition_reference.value.policyDefinitionId, "/managementGroups/plbtf/", "/managementGroups/plbtf${var.environment}/")
      reference_id         = policy_definition_reference.value.policyDefinitionReferenceId
      parameter_values     = jsonencode(policy_definition_reference.value.parameters)
    }
  }
  depends_on = [azurerm_policy_definition.definitions]
}
