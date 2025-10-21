locals {
  # Mapping of folder names to management group IDs
  mg_mapping = {
    "root-mg"      = "plbtf-dev"
    "landing-zone" = "plbtf-landingzones-dev"
  }

  # Discover all policy files across all scope folders
  all_policy_files = flatten([
    for scope_folder in keys(local.mg_mapping) : [
      for file in fileset("${path.module}/policies/definitions/scope/${scope_folder}/policies", "*.jsonc") : {
        scope_folder   = scope_folder
        filename       = file
        policy_name    = trimsuffix(file, ".jsonc")
        mg_id          = local.mg_mapping[scope_folder]
        policy_content = jsondecode(file("${path.module}/policies/definitions/scope/${scope_folder}/policies/${file}"))
      }
    ]
  ])

  # Create a map with unique keys for for_each
  policies = {
    for policy in local.all_policy_files :
    "${policy.scope_folder}-${policy.policy_name}" => policy
  }
}

resource "azapi_resource" "policy_definitions" {
  for_each  = local.policies
  type      = "Microsoft.Authorization/policyDefinitions@2021-06-01"
  name      = each.value.policy_name
  parent_id = "/providers/Microsoft.Management/managementGroups/${each.value.mg_id}"
  body = {
    properties = each.value.policy_content
  }
}
