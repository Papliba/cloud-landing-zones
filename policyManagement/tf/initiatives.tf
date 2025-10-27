locals {
  # Discover all policy initiative JSON files across all management group scopes
  # Note: JSONC files are automatically converted to JSON by the pipeline before Terraform runs
  # The folder structure determines deployment scope: policies/definitions/scope/{mg-name}/initiatives/*.json

  # Find all initiative files with their full paths
  all_initiative_files = fileset("${path.module}/policies/definitions/scope", "**/initiatives/*.json")

  # Parse initiative files and extract management group from path
  # fileset returns paths relative to the base directory, e.g., "plbtf-sandbox-test/initiatives/file.json"
  initiative_definitions = {
    for file_path in local.all_initiative_files :
    "${regex("^([^/]+)/", file_path)[0]}-${replace(basename(file_path), ".json", "")}" => {
      content             = jsondecode(file("${path.module}/policies/definitions/scope/${file_path}"))
      management_group_id = regex("^([^/]+)/", file_path)[0]
      file_path           = file_path
    }
  }
}

resource "azurerm_policy_set_definition" "initiatives" {
  for_each = local.initiative_definitions

  name                = each.value.content.name
  policy_type         = "Custom"
  # management_group_id = each.value.management_group_id
  display_name        = each.value.content.properties.displayName
  description         = each.value.content.properties.description

  metadata = jsonencode(each.value.content.properties.metadata)

  parameters = jsonencode(each.value.content.properties.parameters)

  dynamic "policy_definition_reference" {
    for_each = each.value.content.properties.policyDefinitions
    content {
      policy_definition_id = policy_definition_reference.value.policyDefinitionId
      parameter_values     = jsonencode(policy_definition_reference.value.parameters)
    }
  }
}
